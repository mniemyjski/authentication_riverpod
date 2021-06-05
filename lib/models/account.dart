import 'package:equatable/equatable.dart';

class Account extends Equatable {
  Account({
    this.uid = '',
    this.name = '',
    this.photoUrl = '',
  });

  final String uid;
  final String name;
  final String photoUrl;

  @override
  List<Object> get props => [this.name, this.photoUrl, this.uid];

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      uid: map['uid'] as String,
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'uid': this.uid,
      'name': this.name,
      'photoUrl': this.photoUrl,
    } as Map<String, dynamic>;
  }

  Account copyWith({
    String? uid,
    String? name,
    String? photoUrl,
  }) {
    if ((uid == null || identical(uid, this.uid)) &&
        (name == null || identical(name, this.name)) &&
        (photoUrl == null || identical(photoUrl, this.photoUrl))) {
      return this;
    }

    return new Account(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
