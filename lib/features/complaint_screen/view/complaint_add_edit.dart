import 'package:edu_tara/core/utils/helper_function.dart';
import 'package:edu_tara/features/complaint_screen/controller/complaint_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ComplaintAddEditView extends StatefulWidget {
  final bool isEdit;
  final String? complaintId;
  final String? name;
  final String? age;
  final String? address;
  final String? complaint;
  final String? phone;
  final String? email;
  final String? state;
  final String? district;
  final String? pincode;

  const ComplaintAddEditView({
    super.key,
    required this.isEdit,
    this.name,
    this.age,
    this.address,
    this.complaint,
    this.phone,
    this.email,
    this.state,
    this.district,
    this.pincode,
    this.complaintId,
  });

  @override
  State<ComplaintAddEditView> createState() => _ComplaintAddEditViewState();
}

class _ComplaintAddEditViewState extends State<ComplaintAddEditView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _complaintController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _pincodeController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  getData() {
    if (widget.isEdit) {
      _nameController.text = widget.name ?? '';
      _ageController.text = widget.age ?? '';
      _addressController.text = widget.address ?? '';
      _complaintController.text = widget.complaint ?? '';
      _phoneController.text = widget.phone ?? '';
      _emailController.text = widget.email ?? '';
      _stateController.text = widget.state ?? '';
      _districtController.text = widget.district ?? '';
      _pincodeController.text = widget.pincode ?? '';
      setState(() {});
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _complaintController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    HapticFeedback.mediumImpact();

    final controller = Provider.of<ComplaintController>(context, listen: false);

    final data = {
      "user": userID,
      "name": _nameController.text,
      "age": _ageController.text,
      "state": _stateController.text,
      "district": _districtController.text,
      "pincode": _pincodeController.text,
      "address": _addressController.text,
      "phone_no": _phoneController.text,
      "email": _emailController.text,
      "complaint": _complaintController.text,
    };

    bool success = false;

    if (widget.isEdit && widget.complaintId != null) {
      success = await controller.editComplaint(
        widget.complaintId!,
        context,
        data,
      );
    } else {
      success = await controller.createComplaint(data, context);
    }

    setState(() => _isSubmitting = false);

    if (success) {
      _formKey.currentState!.reset();
      _nameController.clear();
      _ageController.clear();
      _addressController.clear();
      _complaintController.clear();
      _phoneController.clear();
      _emailController.clear();                 
      _stateController.clear();
      _districtController.clear();
      _pincodeController.clear();
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLength,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint ?? 'Enter your $label',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 14,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white.withOpacity(0.8),
                    size: 20,
                  ),
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 2,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                counterStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              maxLines: maxLines,
              maxLength: maxLength,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              validator: validator,
              textCapitalization: textCapitalization,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    String title,
    String subtitle,
    IconData icon,
    List<Widget> children,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0.05),
            ],
          ),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF667eea).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F0F23),
              Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Submit Complaint',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'We\'re here to help you',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildSectionCard(
                          "Personal Information",
                          "Tell us about yourself",
                          Icons.person_outline,
                          [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildTextField(
                                    controller: _nameController,
                                    label: "Full Name",
                                    icon: Icons.person_outline,
                                    validator: (v) =>
                                        v!.isEmpty ? 'Name is required' : null,
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildTextField(
                                    controller: _ageController,
                                    label: "Age",
                                    icon: Icons.cake_outlined,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    validator: (v) {
                                      if (v == null || v.isEmpty)
                                        return 'Required';
                                      final age = int.tryParse(v);
                                      if (age == null || age < 1 || age > 120) {
                                        return 'Invalid age';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _phoneController,
                                    label: 'Phone Number',
                                    icon: Icons.phone_outlined,
                                    keyboardType: TextInputType.phone,
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'Phone number is required';
                                      }
                                      if (!RegExp(r'^\d{10}$').hasMatch(v)) {
                                        return 'Phone number must be exactly 10 digits';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildTextField(
                                    controller: _emailController,
                                    label: 'Email Address',
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (v) {
                                      if (v == null || v.isEmpty)
                                        return 'Email is required';
                                      if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      ).hasMatch(v)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _stateController,
                                    label: 'State',
                                    icon: Icons.location_on_outlined,
                                    validator: (v) =>
                                        v!.isEmpty ? 'State is required' : null,
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                                const SizedBox(width: 16),

                                Expanded(
                                  child: _buildTextField(
                                    controller: _districtController,
                                    label: 'District',
                                    icon: Icons.location_on_outlined,
                                    validator: (v) => v!.isEmpty
                                        ? 'District is required'
                                        : null,
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _pincodeController,
                                    label: 'Pincode',
                                    icon: Icons.pin_drop,
                                    keyboardType: TextInputType.number,
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'Pincode is required';
                                      }
                                      if (!RegExp(r'^\d{6}$').hasMatch(v)) {
                                        return 'Pincode must be exactly 6 digits';
                                      }
                                      return null;
                                    },
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                                Expanded(child: Text('')),
                              ],
                            ),
                            _buildTextField(
                              controller: _addressController,
                              label: 'Address',
                              icon: Icons.location_on_outlined,
                              maxLines: 2,
                              validator: (v) =>
                                  v!.isEmpty ? 'Address is required' : null,
                              textCapitalization: TextCapitalization.words,
                            ),
                          ],
                        ),
                        _buildSectionCard(
                          "Complaint Details",
                          "Describe your issue in detail",
                          Icons.description_outlined,
                          [
                            _buildTextField(
                              controller: _complaintController,
                              label: 'Complaint Description',
                              icon: Icons.edit_outlined,
                              hint:
                                  'Please provide detailed information about your complaint...',
                              maxLines: 6,
                              maxLength: 500,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (v) {
                                if (widget.isEdit) {
                                  if (v == null || v.length < 20) {
                                    return 'Please provide at least 20 characters';
                                  }
                                }
                                return null; // no error if isEdit is false or length is >= 20
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Submit Button
                        Container(
                          width: 300,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: _isSubmitting
                                ? LinearGradient(
                                    colors: [
                                      Colors.grey.withOpacity(0.5),
                                      Colors.grey.withOpacity(0.3),
                                    ],
                                  )
                                : const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF667eea),
                                      Color(0xFF764ba2),
                                    ],
                                  ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: _isSubmitting
                                ? []
                                : [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF667eea,
                                      ).withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _submitComplaint,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: _isSubmitting
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white.withOpacity(0.7),
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Text(
                                        'Submitting...',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.send_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Submit Complaint',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
