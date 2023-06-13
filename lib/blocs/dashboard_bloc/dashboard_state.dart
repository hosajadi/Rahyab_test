part of 'dashboard_bloc.dart';


class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitState extends DashboardState {
  DashboardInitState();
  @override
  List<Object?> get props => [];
}

class DashboardMainState extends DashboardState {
  final bool sendDataLoading;
  DashboardMainState({required this.sendDataLoading});

  List<Object?> get props => [ sendDataLoading, identityHashCode(this)];
}

class DashboardErrorState extends DashboardState {
  final String header;
  final String message;
  DashboardErrorState({required this.header, required this.message});

  @override
  List<Object?> get props => [header, message, identityHashCode(this)];
}

