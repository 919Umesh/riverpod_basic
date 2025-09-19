import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omspos/screen/home/state/home_state.dart';
import 'package:omspos/widgets/modals/profile_modal.dart';
import 'package:omspos/widgets/modals/property_modal.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeStateProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state to react to changes
    final state = ref.watch(homeStateProvider);
    // Read the notifier for actions
    final notifier = ref.read(homeStateProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  ProfileModalWidget(),
                  const SizedBox(height: 16.0),
                  
                  // Properties section with loading state
                  Row(
                    children: [
                      Text('Properties'),
                      if (state.isLoading)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: state.isLoading 
                            ? null 
                            : () => notifier.refreshProperties(),
                      ),
                    ],
                  ),
                  
                  // Error message if any
                  if (state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  
                  PropertyModalWidget(properties: state.properties),
                  
                  // Areas section
                  const SizedBox(height: 16.0),
                  Text('Areas'),
                  // You can display areas here similarly
                ]),
              ),
            ),
          ],
        ),
        
        // Floating action button for refresh all
        floatingActionButton: FloatingActionButton(
          onPressed: state.isLoading ? null : () => notifier.initialize(),
          child: state.isLoading 
              ? CircularProgressIndicator(color: Colors.white)
              : Icon(Icons.refresh),
        ),
      ),
    );
  }
}
