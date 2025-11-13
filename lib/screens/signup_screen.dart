import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../database/database_helper.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import '../models/student.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _yearController = TextEditingController();
  final _deptController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  // Interest selection
  final List<String> _availableInterests = [
    'Coding','Sports','Music','Art','Dance','Photography','Gaming','Reading','Writing','Volunteering','Robotics','Design'
  ];
  final Set<String> _selectedInterests = {};

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _yearController.dispose();
    _deptController.dispose();
    _contactController.dispose();
    _passwordController.dispose(); // ✅ fixed
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedInterests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one field of interest'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final student = Student(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text, // ✅ fixed
      year: _yearController.text.trim(),
      deptName: _deptController.text.trim(),
      fieldOfInterest: _selectedInterests.join(', '),
      clubsJoined: null,
      contactInfo: _contactController.text.trim(),
    );

    try {
      if (kIsWeb) {
        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Signup successful!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(student: student),
          ),
        );
      } else {
        // save student in DB
        final id = await DatabaseHelper.instance.insertStudent(student);
        if (!mounted) return;

        if (id > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signup successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(student: student),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signup failed!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showInterestSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Your Interests',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: _availableInterests.length,
                    itemBuilder: (context, index) {
                      final interest = _availableInterests[index];
                      final isSelected = _selectedInterests.contains(interest);
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            if (isSelected) {
                              _selectedInterests.remove(interest);
                            } else {
                              _selectedInterests.add(interest);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent
                                : AppColors.secondaryBackground
                                    .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.accent
                                  : AppColors.secondaryBackground
                                      .withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              interest,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          Positioned(
            bottom: -50,
            left: -50,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 200),
              painter: WavePainter(
                color: AppColors.secondaryBackground.withOpacity(0.6),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: AppColors.primary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Logo + App Name
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Icon(
                          Icons.groups_rounded,
                          size: 50,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('ClubHub',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            letterSpacing: 2,
                          )),
                      Text('CONNECT & ENGAGE',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          )),
                      const SizedBox(height: 40),
                      Text('Create your account',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(height: 20),
                      Text('Sign Up',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          )),
                      const SizedBox(height: 32),

                      _buildTextField(controller: _nameController, hintText: 'Full name', icon: Icons.person_outline, validator: (v) => v!.isEmpty ? 'Enter full name' : null),
                      const SizedBox(height: 16),
                      _buildTextField(controller: _emailController, hintText: 'Email address', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, validator: (v){if(v==null||v.isEmpty)return 'Enter email'; if(!v.contains('@')) return 'Enter valid email'; return null;}),
                      const SizedBox(height: 16),
                      _buildTextField(controller: _yearController, hintText: 'Year (e.g., 1st, 2nd, 3rd, 4th)', icon: Icons.calendar_today_outlined, validator: (v)=>v!.isEmpty?'Enter year':null),
                      const SizedBox(height: 16),
                      _buildTextField(controller: _deptController, hintText: 'Department (e.g., CSE, EEE, MECHA, CIVIL)', icon: Icons.school_outlined, validator: (v)=>v!.isEmpty?'Enter department':null),
                      const SizedBox(height: 16),
                      _buildTextField(controller: _contactController, hintText: 'Contact number', icon: Icons.phone_outlined, keyboardType: TextInputType.phone, validator: (v)=>v!.isEmpty?'Enter contact number':null),
                      const SizedBox(height: 16),

                      // Password field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.secondaryBackground.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.6), fontSize: 15),
                            prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary, size: 22),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textSecondary),
                              onPressed: ()=>setState(()=>_obscurePassword=!_obscurePassword),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          ),
                          validator: (v){if(v==null||v.isEmpty)return 'Enter password'; if(v.length<6)return 'Password must be at least 6 characters'; return null;},
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Interests
                      GestureDetector(
                        onTap: _showInterestSelector,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.secondaryBackground.withOpacity(0.5), width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.interests_outlined, color: AppColors.primary, size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _selectedInterests.isEmpty ? 'Select your field of interest' : _selectedInterests.join(', '),
                                  style: TextStyle(color: _selectedInterests.isEmpty ? AppColors.textSecondary.withOpacity(0.6) : AppColors.textDark, fontSize: 15),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary, size: 16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _isLoading?null:_signup,
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 2),
                          child: _isLoading?const SizedBox(height:22,width:22,child:CircularProgressIndicator(color:Colors.white, strokeWidth:2.5)) : const Text('Sign Up', style: TextStyle(fontSize:17,fontWeight:FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon(Icons.apple, Colors.black),
                          const SizedBox(width: 20),
                          _buildSocialIcon(Icons.g_mobiledata, const Color(0xFFDB4437)),
                          const SizedBox(width: 20),
                          _buildSocialIcon(Icons.facebook, const Color(0xFF1877F2)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                          TextButton(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
                            },
                            child: Text('Login', style: TextStyle(color: AppColors.accent,fontWeight: FontWeight.bold,fontSize:14)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hintText, required IconData icon, TextInputType? keyboardType, String? Function(String?)? validator}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryBackground.withOpacity(0.5), width: 1.5),
      ),
      child: TextFormField(controller: controller, keyboardType: keyboardType, decoration: InputDecoration(hintText: hintText, hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.6), fontSize: 15), prefixIcon: Icon(icon,color: AppColors.primary,size:22), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal:16,vertical:16)), validator: validator),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color){
    return Container(width:54,height:54,decoration:BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(14),border:Border.all(color:AppColors.secondaryBackground.withOpacity(0.4),width:1.5),boxShadow:[BoxShadow(color:Colors.black.withOpacity(0.04),blurRadius:8,offset:const Offset(0,2))]),child: Icon(icon,color:color,size:28));
  }
}

// WavePainter now accepts color parameter
class WavePainter extends CustomPainter {
  final Color color;
  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size){
    final paint = Paint()..color=color;
    final path = Path();
    path.lineTo(0,size.height*0.8);
    path.quadraticBezierTo(size.width*0.25,size.height*0.7,size.width*0.5,size.height*0.8);
    path.quadraticBezierTo(size.width*0.75,size.height*0.9,size.width,size.height*0.8);
    path.lineTo(size.width,0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
