import 'package:edu_tara/core/utils/helper_function.dart';
import 'package:edu_tara/features/complaint_screen/controller/complaint_controller.dart';
import 'package:edu_tara/features/complaint_screen/view/complaint_add_edit.dart';
import 'package:edu_tara/features/complaint_screen/view/complaints_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ComplaintsList extends StatefulWidget {
  const ComplaintsList({super.key});

  @override
  State<ComplaintsList> createState() => _ComplaintsListState();
}

class _ComplaintsListState extends State<ComplaintsList> {
  late ComplaintController controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = Provider.of<ComplaintController>(context, listen: false);
      controller.fetchComplaints(int.parse(userID));
    });
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
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complaints',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Manage and track complaints',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     gradient: const LinearGradient(
                    //       colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    //     ),
                    //     borderRadius: BorderRadius.circular(16),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: const Color(0xFF667eea).withOpacity(0.3),
                    //         blurRadius: 12,
                    //         offset: const Offset(0, 6),
                    //       ),
                    //     ],
                    //   ),
                    //   child: IconButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => ComplaintAddEditView(
                    //             isEdit: false,
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     icon: const Icon(
                    //       Icons.add,
                    //       color: Colors.white,
                    //       size: 24,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              // Complaints List
              Consumer<ComplaintController>(
                builder: (context, controller, _) {
                  return Expanded(
                    child: controller.isLoadingForFetch
                        ? Center(child: CircularProgressIndicator())
                        : controller.complaints.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 80,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No complaints found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            itemCount: controller.complaints.length,
                            itemBuilder: (context, index) {
                              final complaint = controller.complaints[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.15),
                                      Colors.white.withOpacity(0.05),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(20),
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF667eea),
                                          Color(0xFF764ba2),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  title: Text(
                                    complaint.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Addrees: ${complaint.address}, ${complaint.state}, ${complaint.district}, ${complaint.pincode}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: PopupMenuButton<String>(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                      color: const Color(0xFF1A1A2E),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      onSelected: (value) {
                                        if (value == 'view') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ComplaintsDetailsView(
                                                    complaintId:
                                                        complaint.caseId ?? '',
                                                  ),
                                            ),
                                          );
                                        } else if (value == 'edit') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ComplaintAddEditView(
                                                    isEdit: true,
                                                    complaintId:
                                                        complaint.caseId,
                                                    name: complaint.name,
                                                    age: complaint.age
                                                        .toString(),
                                                    address: complaint.address,
                                                    complaint:
                                                        complaint.complaint,
                                                    phone: complaint.phoneNo,
                                                    email: complaint.email,
                                                    state: complaint.state,
                                                    district:
                                                        complaint.district,
                                                    pincode: complaint.pincode,
                                                  ),
                                            ),
                                          );
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 'view',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.visibility_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'View',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Edit',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
