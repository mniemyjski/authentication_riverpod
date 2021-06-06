import 'package:authentication_riverpod/models/models.dart';
import 'package:equatable/equatable.dart';

enum ETypePreferenceState { unknown, uncreated, created }

class PreferenceState extends Equatable {
  final Preference? preference;
  final ETypePreferenceState state;

  PreferenceState({this.preference, this.state = ETypePreferenceState.unknown});

  factory PreferenceState.initial() {
    return PreferenceState();
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [preference, state];

  PreferenceState copyWith({
    Preference? preference,
    ETypePreferenceState? state,
  }) {
    if ((preference == null || identical(preference, this.preference)) && (state == null || identical(state, this.state))) {
      return this;
    }

    return new PreferenceState(
      preference: preference ?? this.preference,
      state: state ?? this.state,
    );
  }
}
