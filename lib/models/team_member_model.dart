enum MemberStatus { active, pendingInvite }
enum MemberRole { owner, admin, personel, viewer }

class TeamMemberModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final MemberRole role;
  final MemberStatus status;
  final String? avatarInitials;
  final Map<String, List<String>> appPermissions;

  const TeamMemberModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    required this.status,
    this.avatarInitials,
    required this.appPermissions,
  });

  String get roleLabel {
    switch (role) {
      case MemberRole.owner:
        return 'Sahip';
      case MemberRole.admin:
        return 'Yönetici';
      case MemberRole.personel:
        return 'Personel';
      case MemberRole.viewer:
        return 'Gözlemci';
    }
  }

  String get statusLabel {
    switch (status) {
      case MemberStatus.active:
        return 'Aktif';
      case MemberStatus.pendingInvite:
        return 'Davet Bekliyor';
    }
  }

  String get initials {
    if (avatarInitials != null) return avatarInitials!;
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  }
}

final List<TeamMemberModel> mockTeamMembers = [
  TeamMemberModel(
    id: '1',
    name: 'Eren Asan',
    email: 'eren@sirket.com',
    role: MemberRole.owner,
    status: MemberStatus.active,
    appPermissions: {
      'vardiya': [
        'Tüm vardiyaları görüntüle',
        'Vardiya düzenle',
        'Rapor indir',
      ],
      'odeme': ['Ödemeleri görüntüle', 'Ödeme ekle', 'Ödeme düzenle'],
      'rezervasyon': ['Rezervasyonları görüntüle', 'Rezervasyon ekle'],
    },
  ),
  TeamMemberModel(
    id: '2',
    name: 'Ahmet Yılmaz',
    email: 'ahmet@sirket.com',
    role: MemberRole.personel,
    status: MemberStatus.active,
    appPermissions: {
      'vardiya': ['Kendi vardiyasını görüntüle', 'Vardiya girişi yap'],
    },
  ),
  TeamMemberModel(
    id: '3',
    name: 'Zeynep Kaya',
    email: 'zeynep@sirket.com',
    role: MemberRole.admin,
    status: MemberStatus.active,
    appPermissions: {
      'vardiya': [
        'Tüm vardiyaları görüntüle',
        'Vardiya düzenle',
      ],
      'rezervasyon': [
        'Rezervasyonları görüntüle',
        'Rezervasyon ekle',
        'Rezervasyon düzenle',
      ],
    },
  ),
  TeamMemberModel(
    id: '4',
    name: 'Murat Demir',
    email: 'murat@gmail.com',
    role: MemberRole.personel,
    status: MemberStatus.pendingInvite,
    appPermissions: {},
  ),
];
