import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:therapist/core/utils/api_status_enum.dart';
import 'package:therapist/model/consultation/consultation_request_model.dart';
import 'package:therapist/presentation/widgets/snackbar_service.dart';
import 'package:therapist/provider/consultation_provider.dart';

class ConsultationRequestsScreen extends StatefulWidget {
  const ConsultationRequestsScreen({super.key});

  @override
  State<ConsultationRequestsScreen> createState() => _ConsultationRequestsScreenState();
}

class _ConsultationRequestsScreenState extends State<ConsultationRequestsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DateFormat dateFormat = DateFormat('MMM d, yyyy');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ConsultationProvider>(context, listen: false)
          .fetchConsultationRequests();
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ConsultationProvider>();
      if(provider.sessionUpdateStatus.isSuccess) {
        SnackbarService.showSuccess('Consultation request updated successfully.');
        provider.fetchConsultationRequests();
        context.read<ConsultationProvider>().resetSessionUpdateStatus();
      } else if(provider.sessionUpdateStatus.isFailure) {
        SnackbarService.showError('Soemething went wrong. Please try again.');
        context.read<ConsultationProvider>().resetSessionUpdateStatus();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ConsultationProvider>(context, listen: true).sessionUpdateStatus;
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5), // Light purple background
      appBar: AppBar(
      leading: GestureDetector(
        child: IconButton(
          icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white.withOpacity(0.9),
          ),
          onPressed: () {
            context.read<ConsultationProvider>().fetchConsultationRequests();
            Navigator.pop(context);
          }
        ),
      ),
      centerTitle: true,
      title: Text(
        'Consultation Requests',
        style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontWeight: FontWeight.bold,
        fontSize: 20,
        ),
      ),
      backgroundColor: const Color(0xFF6A1B9A), // Deep purple
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
        tabs: const [
          Tab(text: 'Pending'),
          Tab(text: 'Accepted'),
          Tab(text: 'Declined'),
        ],
        ),
      ),
      ),
      body: Consumer<ConsultationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6A1B9A),
              ),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 70,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Unable to load requests',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      provider.error!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        provider.fetchConsultationRequests();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A1B9A),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: const Color(0xFF6A1B9A),
            onRefresh: () async {
              await provider.fetchConsultationRequests();
            },
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRequestsList(provider.pendingRequests),
                _buildRequestsList(provider.acceptedRequests),
                _buildRequestsList(provider.declinedRequests),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestsList(List<ConsultationRequestModel> requests) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6A1B9A).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                size: 48,
                color: const Color(0xFF6A1B9A).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No requests found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Any new consultation requests will appear here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return _buildRequestCard(request);
      },
    );
  }

  Widget _buildRequestCard(ConsultationRequestModel request) {
    Color statusColor;
    IconData statusIcon;
    String statusText;
    
    switch (request.status) {
      case 'accepted':
        statusColor = Colors.green[700]!;
        statusIcon = Icons.check_circle;
        statusText = 'Accepted';
        break;
      case 'declined':
        statusColor = Colors.red[700]!;
        statusIcon = Icons.cancel;
        statusText = 'Declined';
        break;
      default:
        statusColor = Colors.orange[700]!;
        statusIcon = Icons.pending_actions;
        statusText = 'Pending';
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFF6A1B9A).withOpacity(0.15),
                  child: Text(
                    request.patientName[0].toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF6A1B9A),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.patientName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Text(
                      //   request.assessmentType,
                      //   style: TextStyle(
                      //     color: Colors.grey[700],
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Requested: ${dateFormat.format(DateTime.parse(request.timestamp!))}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: 14,
                        color: statusColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (request.timestamp != null) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.event_available,
                    size: 18,
                    color: Colors.green[700],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Scheduled: ${DateFormat('EEEE, MMM d • h:mm a').format(DateTime.parse(request.timestamp!))}',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
            if (request.status == 'pending') ...[
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showDeclineDialog(request.id),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red[700],
                        side: BorderSide(
                            color: Colors.red[700]!.withOpacity(0.7)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Decline',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showAcceptDialog(request.id,request.timestamp),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A1B9A),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Accept',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

   void _showAcceptDialog(String sessionId, String? timestamp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Consultation',
          style: TextStyle(color: const Color(0xFF6A1B9A).withOpacity(0.9)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'You are about to accept this consultation request for:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6A1B9A).withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF6A1B9A).withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: const Color(0xFF6A1B9A).withOpacity(0.8),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      dateFormat.format(DateTime.parse(timestamp!)),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ConsultationProvider>().updateConsultationRequest(sessionId, 'accepted', null);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A1B9A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  void _showDeclineDialog(String sessionId) {
    final TextEditingController declineReasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Decline Consultation',
          style: TextStyle(color: Colors.red[400]),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please provide a reason for declining:'),
            const SizedBox(height: 16),
            TextField(
              controller: declineReasonController,
              decoration: InputDecoration(
                hintText: 'Reason for declining',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (declineReasonController.text.trim().isEmpty) {
                SnackbarService.showInfo(
                  'Please provide a reason for declining the request.',
                );
                return;
              }

              context.read<ConsultationProvider>().updateConsultationRequest(
                sessionId,
                'declined',
                declineReasonController.text.trim(),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Decline', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}