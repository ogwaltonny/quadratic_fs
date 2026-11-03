import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// ═══════════════════════════════════════════════════════════════════════════
//  QUADRATIC FINANCIAL SERVICES — Money Lending Management System
// ═══════════════════════════════════════════════════════════════════════════

class C {
  static const primary = Color(0xFF78350F);
  static const primaryDark = Color(0xFF5C2A0C);
  static const accent = Color(0xFFFBBF24);
  static const success = Color(0xFF059669);
  static const danger = Color(0xFFDC2626);
  static const warning = Color(0xFFD97706);
  static const info = Color(0xFF2563EB);
  static const bg = Color(0xFFF4F7FC);
  static const card = Colors.white;
  static const border = Color(0xFFE9EDF2);
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF1E293B);
  static const textMuted = Color(0xFF64748B);
  static const textFaint = Color(0xFF94A3B8);
}

// ─── Models ───────────────────────────────────────────────────────────────
class Customer {
  final int id;
  String firstName, lastName, phone, district, occupation, placeOfWork;
  String idType, idNumber, email;
  num monthlyIncome;
  Uint8List? photo;

  String guarantorFirstName, guarantorLastName, guarantorPhone;
  String guarantorDistrict, guarantorOccupation, guarantorPlaceOfWork;
  String guarantorIdType, guarantorIdNumber, guarantorEmail;
  String guarantorLocation;
  num guarantorIncome;
  Uint8List? guarantorPhoto;

  int? branchId;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.district,
    required this.monthlyIncome,
    this.occupation = '',
    this.placeOfWork = '',
    this.idType = '',
    this.idNumber = '',
    this.email = '',
    this.photo,
    this.guarantorFirstName = '',
    this.guarantorLastName = '',
    this.guarantorPhone = '',
    this.guarantorDistrict = '',
    this.guarantorOccupation = '',
    this.guarantorPlaceOfWork = '',
    this.guarantorIdType = '',
    this.guarantorIdNumber = '',
    this.guarantorEmail = '',
    this.guarantorLocation = '',
    this.guarantorIncome = 0,
    this.guarantorPhoto,
    this.branchId,
  });

  String get fullName => '$firstName $lastName';
  String get guarantorName =>
      '$guarantorFirstName $guarantorLastName'.trim();
}

class Payment {
  final num amount;
  final DateTime timestamp;
  Payment(this.amount, this.timestamp);
}

class Loan {
  final int id;
  final int customerId;
  String customerName;
  num amount, rate, emi, processingFee;
  int tenure;
  String status;
  String frequency;
  String loanDate, approverName, approverTitle;
  List<Payment> payments;
  String businessName, businessDistrict, businessLocation, businessNearby;
  num loanAmountFigures;
  String loanAmountWords;
  String securityProperty, securityVehicle, securityVehicleReg, securityNIN;
  int? branchId;

  Loan({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.amount,
    required this.rate,
    required this.tenure,
    required this.emi,
    required this.processingFee,
    required this.status,
    required this.frequency,
    required this.loanDate,
    required this.approverName,
    required this.approverTitle,
    List<Payment>? payments,
    this.businessName = '',
    this.businessDistrict = '',
    this.businessLocation = '',
    this.businessNearby = '',
    this.loanAmountFigures = 0,
    this.loanAmountWords = '',
    this.securityProperty = '',
    this.securityVehicle = '',
    this.securityVehicleReg = '',
    this.securityNIN = '',
    this.branchId,
  }) : payments = payments ?? [];
}

class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters long';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Must contain at least one digit (0-9)';
    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) return 'Must contain letters (a-z, A-Z)';
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-=+/\\]').hasMatch(value)) {
      return 'Must contain at least one special symbol (!@#\$%^&*...)';
    }
    return null;
  }
  static bool isStrong(String value) => validate(value) == null;
}

class Staff {
  final int id;
  String fullName, email, phone, username, role, status;
  String nin, district, dob, password;
  int? branchId;
  Uint8List? photo;
  Staff({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.username,
    required this.role,
    required this.nin,
    required this.district,
    required this.dob,
    required this.password,
    this.status = 'Active',
    this.branchId,
    this.photo,
  });
}

class Branch {
  final int id;
  String name;
  String location;
  String manager;
  Branch({required this.id, required this.name, required this.location, this.manager = ''});
}

class DailyExpense {
  final int id;
  final String date;
  final String description;
  final num amount;
  int? branchId;
  DailyExpense({required this.id, required this.date,
    required this.description, required this.amount, this.branchId});
}

// ─── Roles ────────────────────────────────────────────────────────────────
class Role {
  static const manager = 'manager';
  static const supervisor = 'supervisor';
  static const cashier = 'cashier';
  static const fieldOfficer = 'field_officer';

  static String label(String r) {
    switch (r) {
      case manager: return 'Manager';
      case supervisor: return 'Supervisor';
      case cashier: return 'Cashier';
      case fieldOfficer: return 'Field Officer';
    }
    return r;
  }

  static List<String> pages(String r) {
    switch (r) {
      case manager:
        return ['home','dashboard','customers','loans','payments','reports','branches','staff'];
      case supervisor:
        return ['home','dashboard','customers','loans','payments','reports','staff'];
      case cashier:
        return ['home','dashboard','customers','payments','reports'];
      case fieldOfficer:
        return ['home','dashboard','customers','payments'];
    }
    return [];
  }

  static bool canRegisterCustomer(String r) => r == manager || r == supervisor || r == fieldOfficer;
  static bool canApplyLoan(String r) => r == manager || r == supervisor;
  static bool canRecordPayment(String r) => r == manager || r == cashier || r == fieldOfficer;
  static bool canRegisterStaff(String r) => r == manager || r == supervisor;
  static bool canDeleteCustomer(String r) => r == manager;
  static bool canManageBranches(String r) => r == manager;
  static bool canViewReports(String r) => r == manager || r == supervisor || r == cashier;
  static bool canViewDaily(String r) => r == manager || r == supervisor || r == cashier;
}

// ─── App State ────────────────────────────────────────────────────────────
class AppState extends ChangeNotifier {
  String currentRole = Role.manager;
  String currentUserName = 'Sarah Adong';
  String currentUserAvatar = 'S';
  Uint8List? currentUserPhoto;

  int? activeBranchId;

  List<Customer> customers = [];
  List<Loan> loans = [];
  List<Staff> staffList = [];
  List<Branch> branches = [];
  List<DailyExpense> expenses = [];

  Map<String, num> bankedByDate = {};

  Map<int, int> _branchCustomerCounter = {};
  Map<int, int> _branchLoanCounter = {};
  Map<int, int> _branchStaffCounter = {};
  Map<int, int> _branchExpenseCounter = {};
  int _hqCustomerCounter = 1;
  int _hqLoanCounter = 1;
  int _hqStaffCounter = 1;
  int _hqExpenseCounter = 1;
  int nextBranchId = 1;

  AppState() { _loadSampleData(); _syncUserPhoto(); }

  void refresh() => notifyListeners();

  int nextCustomerIdFor(int? branch) {
    if (branch == null) return _hqCustomerCounter++;
    final v = (_branchCustomerCounter[branch] ?? 1);
    _branchCustomerCounter[branch] = v + 1;
    return v;
  }
  int nextLoanIdFor(int? branch) {
    if (branch == null) return _hqLoanCounter++;
    final v = (_branchLoanCounter[branch] ?? 1);
    _branchLoanCounter[branch] = v + 1;
    return v;
  }
  int nextStaffIdFor(int? branch) {
    if (branch == null) return _hqStaffCounter++;
    final v = (_branchStaffCounter[branch] ?? 1);
    _branchStaffCounter[branch] = v + 1;
    return v;
  }
  int nextExpenseIdFor(int? branch) {
    if (branch == null) return _hqExpenseCounter++;
    final v = (_branchExpenseCounter[branch] ?? 1);
    _branchExpenseCounter[branch] = v + 1;
    return v;
  }

  List<Customer> get visibleCustomers => activeBranchId == null
      ? customers
      : customers.where((c) => c.branchId == activeBranchId).toList();

  List<Loan> get visibleLoans => activeBranchId == null
      ? loans
      : loans.where((l) => l.branchId == activeBranchId).toList();

  List<Staff> get visibleStaff => activeBranchId == null
      ? staffList
      : staffList.where((s) => s.branchId == activeBranchId).toList();

  List<DailyExpense> get visibleExpenses => activeBranchId == null
      ? expenses
      : expenses.where((e) => e.branchId == activeBranchId).toList();

  Branch? get activeBranch => activeBranchId == null
      ? null
      : branches.firstWhere((b) => b.id == activeBranchId,
      orElse: () => Branch(id: 0, name: '', location: ''));

  void enterBranch(int id) { activeBranchId = id; notifyListeners(); }
  void exitBranch() { activeBranchId = null; notifyListeners(); }

  String _bankedKey(String dateIso) => '${activeBranchId ?? 'hq'}|$dateIso';
  void setBanked(String dateIso, num amount) {
    bankedByDate[_bankedKey(dateIso)] = amount;
    notifyListeners();
  }
  num bankedFor(String dateIso) => bankedByDate[_bankedKey(dateIso)] ?? 0;
  bool hasBanked(String dateIso) => bankedByDate.containsKey(_bankedKey(dateIso));

  Staff? currentUser;
  bool get isAuthenticated => currentUser != null;

  void setRole(String role, String name, String avatar) {
    currentRole = role;
    currentUserName = name;
    currentUserAvatar = avatar;
    _syncUserPhoto();
    notifyListeners();
  }

  String? login(String usernameOrEmail, String password) {
    final cleanInput = usernameOrEmail.trim().toLowerCase();
    final cleanPass = password.trim();

    final matches = staffList.where((s) {
      final u = s.username.toLowerCase();
      final e = s.email.toLowerCase();
      final isOgwalManager = (s.role == Role.manager && cleanInput == 'ogwal');
      return u == cleanInput || e == cleanInput || isOgwalManager;
    }).toList();

    if (matches.isEmpty) {
      return 'Account not found. Please contact the Manager.';
    }

    final staff = matches.first;
    if (staff.status != 'Active') {
      return 'Your account is deactivated. Please contact the Manager.';
    }

    if (staff.password != cleanPass) {
      return 'Incorrect password. Please try again.';
    }

    currentUser = staff;
    currentRole = staff.role;
    currentUserName = staff.fullName;
    currentUserAvatar = staff.fullName.isNotEmpty ? staff.fullName[0].toUpperCase() : 'U';
    currentUserPhoto = staff.photo;
    activeBranchId = staff.branchId;
    notifyListeners();
    return null;
  }

  void logout() {
    currentUser = null;
    activeBranchId = null;
    notifyListeners();
  }

  String? changePassword(String currentPass, String newPass, String confirmPass) {
    if (currentUser == null) return 'No user currently logged in.';
    if (currentUser!.password != currentPass.trim()) {
      return 'Current password does not match.';
    }
    if (newPass.trim() != confirmPass.trim()) {
      return 'New password and confirmation do not match.';
    }
    final validationError = PasswordValidator.validate(newPass.trim());
    if (validationError != null) return validationError;

    currentUser!.password = newPass.trim();
    final idx = staffList.indexWhere((s) => s.id == currentUser!.id && s.branchId == currentUser!.branchId);
    if (idx != -1) {
      staffList[idx].password = newPass.trim();
    }
    notifyListeners();
    return null;
  }

  void _syncUserPhoto() {
    final match = staffList.where((s) =>
    s.fullName == currentUserName && s.role == currentRole).toList();
    if (match.isNotEmpty && match.first.photo != null) {
      currentUserPhoto = match.first.photo;
    } else {
      currentUserPhoto = null;
    }
  }

  static num calculatePayment(num principal, num rate, int months, String frequency) {
    int periodsPerYear;
    switch (frequency) {
      case 'Daily': periodsPerYear = 365; break;
      case 'Weekly': periodsPerYear = 52; break;
      default: periodsPerYear = 12;
    }
    final periodRate = rate / (100 * periodsPerYear);
    final totalPeriods = months * (periodsPerYear / 12);
    if (periodRate == 0) return (principal / totalPeriods).round();
    final payment = principal * periodRate * _pow(1 + periodRate, totalPeriods) /
        (_pow(1 + periodRate, totalPeriods) - 1);
    return payment.round();
  }

  static num _pow(num base, num exp) {
    num result = 1;
    for (int i = 0; i < exp.round(); i++) { result *= base; }
    return result;
  }

  static num outstandingBalance(Loan loan) {
    if (loan.payments.isEmpty) return loan.amount.round();
    final totalPaid = loan.payments.fold<num>(0, (s, p) => s + p.amount);
    final balance = loan.amount - totalPaid;
    return balance < 0 ? 0 : balance.round();
  }

  static int overdueDays(Loan loan) {
    try {
      final parts = loan.loanDate.split('-');
      final loanDate = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      int periodsPerYear;
      switch (loan.frequency) {
        case 'Daily': periodsPerYear = 365; break;
        case 'Weekly': periodsPerYear = 52; break;
        default: periodsPerYear = 12;
      }
      final totalPeriods = loan.tenure * (periodsPerYear / 12);
      final dueDate = loanDate.add(Duration(days: (totalPeriods * (365 / periodsPerYear)).round()));
      return DateTime.now().difference(dueDate).inDays;
    } catch (_) { return 0; }
  }

  static num totalPaid(Loan loan) =>
      loan.payments.fold<num>(0, (s, p) => s + p.amount).round();

  static String freqLabel(String f) {
    if (f == 'Daily') return 'per day';
    if (f == 'Weekly') return 'per week';
    if (f == 'Monthly') return 'per month';
    return 'per period';
  }

  void _loadSampleData() {
    branches = [
      Branch(id: 1, name: 'Arua Main', location: 'Arua', manager: 'Sarah Adong'),
      Branch(id: 2, name: 'Kampala Central', location: 'Kampala', manager: 'Sarah Adong'),
    ];
    nextBranchId = 3;

    final aruaCustomers = [
      Customer(id: 1, firstName: 'Grace', lastName: 'Auma', phone: '0777123456',
          district: 'Arua', monthlyIncome: 1200000, occupation: 'Teacher',
          placeOfWork: 'Arua Primary School', email: 'grace@example.com',
          guarantorFirstName: 'Peter', guarantorLastName: 'Otim',
          guarantorLocation: 'Arua Town', guarantorPhone: '0777999888',
          guarantorDistrict: 'Arua', guarantorOccupation: 'Farmer',
          guarantorPlaceOfWork: 'Arua Farm', guarantorIdType: 'National ID',
          guarantorIdNumber: 'CM111111', guarantorEmail: 'peter@example.com',
          guarantorIncome: 600000, branchId: 1),
      Customer(id: 2, firstName: 'John', lastName: 'Okello', phone: '0777654321',
          district: 'Arua', monthlyIncome: 800000, occupation: 'Business Owner',
          placeOfWork: 'Okello General Store', email: 'john@example.com',
          guarantorFirstName: 'Mary', guarantorLastName: 'Adong',
          guarantorLocation: 'Arua', guarantorPhone: '0777333444',
          guarantorDistrict: 'Arua', guarantorOccupation: 'Trader',
          guarantorPlaceOfWork: 'Arua Market', guarantorIdType: 'National ID',
          guarantorIdNumber: 'CM222222', guarantorEmail: 'mary@example.com',
          guarantorIncome: 400000, branchId: 1),
    ];
    final kampalaCustomers = [
      Customer(id: 1, firstName: 'Sarah', lastName: 'Nakato', phone: '0777987654',
          district: 'Kampala', monthlyIncome: 2000000, occupation: 'Civil Servant',
          placeOfWork: 'Kampala City Council', email: 'sarah@example.com',
          guarantorFirstName: 'David', guarantorLastName: 'Mukasa',
          guarantorLocation: 'Kampala', guarantorPhone: '0777777888',
          guarantorDistrict: 'Kampala', guarantorOccupation: 'Engineer',
          guarantorPlaceOfWork: 'KCCA', guarantorIdType: 'National ID',
          guarantorIdNumber: 'CM333333', guarantorEmail: 'david@example.com',
          guarantorIncome: 900000, branchId: 2),
      Customer(id: 2, firstName: 'Ronald', lastName: 'Ssemakula', phone: '0777555444',
          district: 'Kampala', monthlyIncome: 1500000, occupation: 'Trader',
          placeOfWork: 'Owino Market', email: 'ronald@example.com',
          guarantorFirstName: 'Agnes', guarantorLastName: 'Kirabo',
          guarantorLocation: 'Kampala', guarantorPhone: '0777333222',
          guarantorDistrict: 'Kampala', guarantorOccupation: 'Shopkeeper',
          guarantorPlaceOfWork: 'Kampala', guarantorIdType: 'National ID',
          guarantorIdNumber: 'CM444444', guarantorEmail: 'agnes@example.com',
          guarantorIncome: 500000, branchId: 2),
    ];
    customers = [...aruaCustomers, ...kampalaCustomers];

    _branchCustomerCounter[1] = 3;
    _branchCustomerCounter[2] = 3;

    final today = DateTime.now();
    final iso = _todayInput();
    final emiArua1 = calculatePayment(500000, 12, 12, 'Monthly');
    final emiArua2 = calculatePayment(1000000, 15, 18, 'Weekly');
    final emiKamp1 = calculatePayment(750000, 10, 6, 'Daily');
    final emiKamp2 = calculatePayment(400000, 12, 12, 'Monthly');

    loans = [
      Loan(id: 1, customerId: 1, customerName: 'Grace Auma', amount: 500000, rate: 12,
          tenure: 12, emi: emiArua1, processingFee: 10000, status: 'paid',
          frequency: 'Monthly', loanDate: iso,
          approverName: 'Sarah Adong (Manager)', approverTitle: 'Manager', branchId: 1,
          payments: [Payment(510000, today)]),
      Loan(id: 2, customerId: 2, customerName: 'John Okello', amount: 1000000, rate: 15,
          tenure: 18, emi: emiArua2, processingFee: 20000, status: 'overdue',
          frequency: 'Weekly', loanDate: iso,
          approverName: 'John Ochen (Supervisor)', approverTitle: 'Supervisor', branchId: 1,
          payments: [Payment(emiArua2 * 6, today.subtract(const Duration(days: 5)))]),
      Loan(id: 1, customerId: 1, customerName: 'Sarah Nakato', amount: 750000, rate: 10,
          tenure: 6, emi: emiKamp1, processingFee: 15000, status: 'pending',
          frequency: 'Daily', loanDate: iso,
          approverName: 'Sarah Adong (Manager)', approverTitle: 'Manager', branchId: 2,
          payments: [Payment(emiKamp1 * 3, today)]),
      Loan(id: 2, customerId: 2, customerName: 'Ronald Ssemakula', amount: 400000, rate: 12,
          tenure: 12, emi: emiKamp2, processingFee: 8000, status: 'pending',
          frequency: 'Monthly', loanDate: iso,
          approverName: 'Sarah Adong (Manager)', approverTitle: 'Manager', branchId: 2),
    ];
    _branchLoanCounter[1] = 3;
    _branchLoanCounter[2] = 3;

    staffList = [
      Staff(id: 1, fullName: 'Sarah Adong', email: 'sarah@quadratic.com',
          phone: '0777123456', username: 'manager', role: 'manager', nin: 'CM123456',
          district: 'Arua', dob: '1985-05-15', branchId: 1,
          password: r'ogwal88@$ton'),
      Staff(id: 2, fullName: 'Grace Auma', email: 'grace@quadratic.com',
          phone: '0777456789', username: 'grace', role: 'cashier', nin: 'CM345678',
          district: 'Arua', dob: '1995-02-10', branchId: 1,
          password: 'Grace123@#'),
      Staff(id: 1, fullName: 'John Ochen', email: 'john@quadratic.com',
          phone: '0777654321', username: 'john', role: 'supervisor', nin: 'CM789012',
          district: 'Kampala', dob: '1990-08-20', branchId: 2,
          password: 'John123@#'),
      Staff(id: 2, fullName: 'Peter Otim', email: 'peter@quadratic.com',
          phone: '0777567890', username: 'peter', role: 'field_officer', nin: 'CM901234',
          district: 'Kampala', dob: '1992-11-30', branchId: 2,
          password: 'Peter123@#'),
    ];
    _branchStaffCounter[1] = 3;
    _branchStaffCounter[2] = 3;

    expenses = [
      DailyExpense(id: 1, date: iso, description: 'Transport', amount: 5000, branchId: 1),
      DailyExpense(id: 1, date: iso, description: 'Fuel', amount: 8000, branchId: 2),
    ];
    _branchExpenseCounter[1] = 2;
    _branchExpenseCounter[2] = 2;
  }

  static String _todayInput() {
    final d = DateTime.now();
    return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}

final appState = AppState();

String fmt(num amount) {
  final s = amount.round().toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return buf.toString();
}

String todayFormatted() {
  final d = DateTime.now();
  return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

String formatDateTime(DateTime dt) {
  return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} '
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}

String prettyDate(String iso) {
  try {
    final p = iso.split('-');
    return '${p[2]}/${p[1]}/${p[0]}';
  } catch (_) { return iso; }
}

String isoDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

// ═══════════════════════════════════════════════════════════════════════════
//  ROOT APP
// ═══════════════════════════════════════════════════════════════════════════
void main() => runApp(const QuadraticApp());

class QuadraticApp extends StatelessWidget {
  const QuadraticApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) => MaterialApp(
        title: 'Quadratic FS',
        debugShowCheckedModeBanner: false,
        theme: _theme(),
        home: appState.isAuthenticated ? const AppShell() : const LoginScreen(),
      ),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: C.bg,
      colorScheme: ColorScheme.fromSeed(seedColor: C.primary, primary: C.primary),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: C.textPrimary,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFAFBFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: C.accent, width: 2),
        ),
        labelStyle: const TextStyle(color: C.textMuted),
      ),
    );
  }
}

// ─── Nav data ─────────────────────────────────────────────────────────────
class _NavItem {
  final String page, label, section;
  final IconData icon;
  const _NavItem(this.page, this.label, this.icon, this.section);
}

class _ReportSub {
  final String key;
  final String label;
  const _ReportSub(this.key, this.label);
}

const _reportSubs = <_ReportSub>[
  _ReportSub('pending', 'Pending'),
  _ReportSub('overdue', 'Overdue'),
  _ReportSub('paid',    'Paid'),
  _ReportSub('daily',   'Daily Work Accountability'),
];

// ─── Shared avatar widget ────────────────────────────────────────────────
class _UserAvatar extends StatelessWidget {
  final double radius;
  final Color bg;
  final Color fg;
  const _UserAvatar({this.radius = 18, this.bg = C.accent, this.fg = C.primary});

  @override
  Widget build(BuildContext context) {
    final photo = appState.currentUserPhoto;
    if (photo != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: bg,
        backgroundImage: MemoryImage(photo),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: bg,
      foregroundColor: fg,
      child: Text(appState.currentUserAvatar,
          style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

// ─── App Shell (HQ) ───────────────────────────────────────────────────────
class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  String page = 'dashboard';
  String _reportsInitialTab = 'pending';
  bool _reportsExpanded = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const _allItems = [
    _NavItem('home', 'Home', Icons.home_outlined, 'Navigation'),
    _NavItem('dashboard', 'Dashboard', Icons.pie_chart_outline, 'Navigation'),
    _NavItem('customers', 'Customers', Icons.people_outline, 'Main'),
    _NavItem('loans', 'Loans', Icons.description_outlined, 'Main'),
    _NavItem('payments', 'Payments', Icons.payments_outlined, 'Main'),
    _NavItem('reports', 'Reports', Icons.bar_chart, 'Reports'),
    _NavItem('branches', 'Branches', Icons.business_outlined, 'System'),
    _NavItem('staff', 'Staff Management', Icons.manage_accounts_outlined, 'System'),
  ];

  void go(String p) {
    final allowed = Role.pages(appState.currentRole);
    if (!allowed.contains(p)) return;
    setState(() => page = p);
    if (MediaQuery.of(context).size.width < 800) Navigator.pop(context);
  }

  void _goReports(String tabKey) {
    setState(() {
      page = 'reports';
      _reportsInitialTab = tabKey;
      _reportsExpanded = true;
    });
    if (MediaQuery.of(context).size.width < 800) Navigator.pop(context);
  }

  Widget _screen() {
    switch (page) {
      case 'home': return const HomeScreen();
      case 'dashboard': return const DashboardScreen();
      case 'customers': return const CustomersScreen();
      case 'loans': return const LoansScreen();
      case 'payments': return const PaymentsScreen();
      case 'reports': return ReportsScreen(activeReport: _reportsInitialTab);
      case 'branches': return const BranchesScreen();
      case 'staff': return const StaffScreen();
    }
    return const DashboardScreen();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w >= 1000;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isWide ? null : _drawer(),
      backgroundColor: C.bg,
      body: Row(
        children: [
          if (isWide) SizedBox(width: 260, child: _sidebar()),
          Expanded(
            child: Column(
              children: [
                _header(isWide),
                Expanded(child: SingleChildScrollView(child: _screen())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavRow(_NavItem item) {
    final sel = page == item.page && item.page != 'reports';
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: sel ? const Color(0xFF92400E) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (item.page == 'reports') {
              setState(() => _reportsExpanded = !_reportsExpanded);
              if (page != 'reports') go('reports');
            } else {
              go(item.page);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Icon(item.icon, size: 18,
                  color: (sel || (page == 'reports' && item.page == 'reports'))
                      ? C.accent : const Color(0xFFCBD5E1)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(item.label,
                    style: TextStyle(
                      color: (sel || (page == 'reports' && item.page == 'reports'))
                          ? C.accent : const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    )),
              ),
              if (item.page == 'reports')
                Icon(_reportsExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 18, color: const Color(0xFFCBD5E1)),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildReportsSubs() {
    if (!_reportsExpanded) return const SizedBox.shrink();
    if (!Role.canViewReports(appState.currentRole)) return const SizedBox.shrink();
    final canDaily = Role.canViewDaily(appState.currentRole);
    final subs = _reportSubs.where((s) => s.key != 'daily' || canDaily).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 6),
      child: Column(
        children: subs.map((s) {
          final isActiveTab = page == 'reports' && _reportsInitialTab == s.key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Material(
              color: isActiveTab ? const Color(0xFFB45309) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _goReports(s.key),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 9),
                  child: Row(children: [
                    Container(width: 4, height: 4,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            color: isActiveTab ? C.accent : const Color(0xFFCBD5E1))),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(s.label, style: TextStyle(
                        color: isActiveTab ? C.accent : const Color(0xFFCBD5E1),
                        fontSize: 12.5, fontWeight: FontWeight.w500,
                      )),
                    ),
                  ]),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _sidebar() {
    final allowed = Role.pages(appState.currentRole);
    final visible = _allItems.where((i) => allowed.contains(i.page)).toList();

    final children = <Widget>[];
    String lastSection = '';
    for (final item in visible) {
      if (item.section != lastSection) {
        children.add(Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
          child: Text(item.section.toUpperCase(),
              style: const TextStyle(color: C.accent, fontSize: 11,
                  fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        ));
        lastSection = item.section;
      }
      children.add(_buildNavRow(item));
      if (item.page == 'reports') children.add(_buildReportsSubs());
    }

    return Container(
      color: C.primary,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF92400E))),
            ),
            child: Row(children: [
              const Icon(Icons.payments, color: C.accent, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('QUADRATIC',
                    style: TextStyle(color: Colors.white, fontSize: 18,
                        fontWeight: FontWeight.w700, letterSpacing: 0.5)),
              ),
            ]),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              children: children,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFF92400E))),
            ),
            child: Row(children: [
              const _UserAvatar(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appState.currentUserName,
                        style: const TextStyle(color: Colors.white,
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    Text(Role.label(appState.currentRole),
                        style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 11)),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _header(bool isWide) {
    final titles = {
      'home': 'Home', 'dashboard': 'Dashboard', 'customers': 'Customers',
      'loans': 'Loans', 'payments': 'Payments',
      'reports': 'Reports — ${_reportSubs.firstWhere((s) => s.key == _reportsInitialTab, orElse: () => const _ReportSub('pending', 'Pending')).label}',
      'branches': 'Branches', 'staff': 'Staff Management',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: C.border)),
      ),
      child: Row(
        children: [
          if (!isWide)
            IconButton(
              icon: const Icon(Icons.menu, color: C.textPrimary),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          Expanded(
            child: Text(titles[page] ?? '',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,
                    color: C.textPrimary)),
          ),
          if (isWide)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(todayFormatted(),
                  style: const TextStyle(fontSize: 13, color: C.textMuted)),
            ),
          const SizedBox(width: 12),
          PopupMenuButton<String>(
            tooltip: 'Account Menu',
            child: const _UserAvatar(),
            onSelected: (v) {
              if (v == 'change_password') {
                showDialog(
                  context: context,
                  builder: (_) => const ChangePasswordDialog(),
                );
              } else if (v == 'logout') {
                appState.logout();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appState.currentUserName,
                        style: const TextStyle(fontWeight: FontWeight.w700, color: C.textPrimary)),
                    Text(Role.label(appState.currentRole),
                        style: const TextStyle(fontSize: 11, color: C.textMuted)),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'change_password',
                child: Row(children: [
                  Icon(Icons.lock_reset, size: 18, color: C.primary),
                  SizedBox(width: 10),
                  Text('Change Password'),
                ]),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(children: [
                  Icon(Icons.logout, size: 18, color: C.danger),
                  SizedBox(width: 10),
                  Text('Sign Out', style: TextStyle(color: C.danger)),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawer() => Drawer(
    backgroundColor: C.primary,
    child: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF92400E))),
            ),
            child: Row(children: [
              const Icon(Icons.payments, color: C.accent, size: 28),
              const SizedBox(width: 10),
              const Text('QUADRATIC',
                  style: TextStyle(color: Colors.white, fontSize: 18,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: () => Navigator.pop(context),
              ),
            ]),
          ),
          Expanded(child: _sidebar()),
        ],
      ),
    ),
  );
}

// ─── Shared widgets ───────────────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  final String icon;
  final String text;
  const SectionTitle(this.icon, this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(children: [
      Text(icon, style: const TextStyle(fontSize: 18)),
      const SizedBox(width: 8),
      Text(text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
              color: C.textPrimary)),
    ]),
  );
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? change;
  final bool negative;
  final VoidCallback? onTap;
  const StatCard({super.key, required this.label, required this.value,
    this.change, this.negative = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: C.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: onTap != null ? C.accent : C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Text(label,
                  style: const TextStyle(fontSize: 13,
                      color: C.textMuted, fontWeight: FontWeight.w500)),
            ),
            if (onTap != null) const Icon(Icons.edit, size: 14, color: C.accent),
          ]),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700,
                  color: C.textPrimary)),
          if (change != null) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: negative ? const Color(0xFFFEE2E2) : const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(change!,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500,
                      color: negative ? C.danger : C.success)),
            ),
          ],
        ],
      ),
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(16), child: card);
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    String text = status;
    switch (status.toLowerCase()) {
      case 'pending':
        bg = const Color(0xFFFEF9C3); fg = const Color(0xFF854D0E); text = 'Pending'; break;
      case 'paid':
        bg = const Color(0xFFDCFCE7); fg = const Color(0xFF166534); text = 'Paid'; break;
      case 'overdue':
        bg = const Color(0xFFFEE2E2); fg = const Color(0xFF991B1B); text = 'Overdue'; break;
      case 'active':
        bg = const Color(0xFFDBEAFE); fg = const Color(0xFF1E40AF); text = 'Active'; break;
      case 'inactive':
        bg = const Color(0xFFFEE2E2); fg = const Color(0xFF991B1B); text = 'Inactive'; break;
      default:
        bg = const Color(0xFFE2E8F0); fg = const Color(0xFF475569);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(fontSize: 11,
          fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

class FreqBadge extends StatelessWidget {
  final String frequency;
  const FreqBadge(this.frequency, {super.key});
  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (frequency) {
      case 'Daily': bg = const Color(0xFFD1FAE5); fg = const Color(0xFF065F46); break;
      case 'Weekly': bg = const Color(0xFFFEF3C7); fg = const Color(0xFF92400E); break;
      case 'Monthly': bg = const Color(0xFFDBEAFE); fg = const Color(0xFF1E40AF); break;
      default: bg = const Color(0xFFE2E8F0); fg = const Color(0xFF475569);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(frequency.isEmpty ? 'N/A' : frequency,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const SectionCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: C.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: C.border)),
            ),
            child: Text(title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                    color: C.textPrimary)),
          ),
          Padding(padding: const EdgeInsets.all(20), child: child),
        ],
      ),
    );
  }
}

class PageWrap extends StatelessWidget {
  final List<Widget> children;
  const PageWrap({super.key, required this.children});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  1. HOME
// ═══════════════════════════════════════════════════════════════════════════
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = '${now.day} ${_month(now.month)} ${now.year}';
    final branchLabel = appState.activeBranch?.name ?? 'HQ';
    final photo = appState.currentUserPhoto;

    return PageWrap(children: [
      Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 560),
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [C.primary, Color(0xFF0F172A)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: C.accent, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12, offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: photo != null
                    ? CircleAvatar(
                  radius: 48,
                  backgroundImage: MemoryImage(photo),
                )
                    : CircleAvatar(
                  radius: 48,
                  backgroundColor: C.accent,
                  foregroundColor: C.primary,
                  child: Text(appState.currentUserAvatar,
                      style: const TextStyle(fontSize: 36,
                          fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Welcome,',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text(appState.currentUserName,
                  style: const TextStyle(color: C.accent, fontSize: 22,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('${Role.label(appState.currentRole)} · $branchLabel',
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
              const SizedBox(height: 16),
              Container(width: 40, height: 2, color: C.accent),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _info('Date', dateStr),
                  const SizedBox(width: 28),
                  _info('Role', Role.label(appState.currentRole)),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _info(String label, String value) => Column(children: [
    Text(label.toUpperCase(),
        style: const TextStyle(color: Color(0xFF64748B), fontSize: 10,
            letterSpacing: 0.5)),
    const SizedBox(height: 2),
    Text(value, style: const TextStyle(color: Color(0xFFE2E8F0),
        fontSize: 13, fontWeight: FontWeight.w600)),
  ]);

  static String _month(int m) => const [
    '', 'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ][m];
}

// ═══════════════════════════════════════════════════════════════════════════
//  2. DASHBOARD
// ═══════════════════════════════════════════════════════════════════════════
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) {
        final customers = appState.visibleCustomers.length;
        final loans = appState.visibleLoans;
        final pending = loans.where((l) => l.status == 'pending').length;
        final overdue = loans.where((l) => l.status == 'overdue').length;
        final paid = loans.where((l) => l.status == 'paid').length;
        final recent = loans.reversed.take(5).toList();

        return PageWrap(children: [
          LayoutBuilder(builder: (_, c) {
            final cols = c.maxWidth > 900 ? 4 : (c.maxWidth > 500 ? 2 : 1);
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.6,
              children: [
                StatCard(label: 'Total Customers', value: '$customers'),
                StatCard(label: 'Pending Loans', value: '$pending'),
                StatCard(label: 'Overdue Loans', value: '$overdue'),
                StatCard(label: 'Paid Loans', value: '$paid'),
              ],
            );
          }),
          const SizedBox(height: 24),
          SectionCard(title: '🕐 Recent Loans', child: _recentTable(recent)),
        ]);
      },
    );
  }

  Widget _recentTable(List<Loan> list) {
    if (list.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(20),
          child: Text('No recent loans', style: TextStyle(color: C.textFaint))));
    }
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 32,
        headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('CUSTOMER')),
          DataColumn(label: Text('AMOUNT')),
          DataColumn(label: Text('EMI')),
          DataColumn(label: Text('FREQUENCY')),
          DataColumn(label: Text('STATUS')),
        ],
        rows: list.map((l) => DataRow(cells: [
          DataCell(Text('#${l.id}')),
          DataCell(Text(l.customerName, style: const TextStyle(fontWeight: FontWeight.w600))),
          DataCell(Text('UGX ${fmt(l.amount)}')),
          DataCell(Text('UGX ${fmt(l.emi)}')),
          DataCell(FreqBadge(l.frequency)),
          DataCell(StatusBadge(l.status)),
        ])).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  3. CUSTOMERS — full guarantor block
// ═══════════════════════════════════════════════════════════════════════════
class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});
  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final _searchCtrl = TextEditingController();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  final _district = TextEditingController();
  final _income = TextEditingController();
  final _occupation = TextEditingController();
  final _placeOfWork = TextEditingController();
  final _idNumber = TextEditingController();
  final _email = TextEditingController();
  String _idType = '';

  final _gFirstName = TextEditingController();
  final _gLastName = TextEditingController();
  final _gPhone = TextEditingController();
  final _gDistrict = TextEditingController();
  final _gIncome = TextEditingController();
  final _gOccupation = TextEditingController();
  final _gPlaceOfWork = TextEditingController();
  final _gIdNumber = TextEditingController();
  final _gEmail = TextEditingController();
  final _gLocation = TextEditingController();
  String _gIdType = '';

  int? _branchId;
  Uint8List? _photoBytes;
  Uint8List? _guarantorBytes;
  final _picker = ImagePicker();

  @override
  void dispose() {
    for (final c in [_searchCtrl, _firstName, _lastName, _phone, _district,
      _income, _occupation, _placeOfWork, _idNumber, _email,
      _gFirstName, _gLastName, _gPhone, _gDistrict, _gIncome,
      _gOccupation, _gPlaceOfWork, _gIdNumber, _gEmail, _gLocation]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickPhoto({required bool isGuarantor}) async {
    try {
      final file = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 70, maxWidth: 800);
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      setState(() {
        if (isGuarantor) { _guarantorBytes = bytes; } else { _photoBytes = bytes; }
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Could not get image: $e')));
    }
  }

  void _clearPhoto({required bool isGuarantor}) {
    setState(() {
      if (isGuarantor) { _guarantorBytes = null; } else { _photoBytes = null; }
    });
  }

  void _register() {
    if (_firstName.text.isEmpty || _lastName.text.isEmpty || _phone.text.isEmpty ||
        _district.text.isEmpty || _income.text.isEmpty || _idType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all customer fields')));
      return;
    }
    if (_photoBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer photo required')));
      return;
    }
    if (_gFirstName.text.isEmpty || _gLastName.text.isEmpty || _gPhone.text.isEmpty ||
        _gDistrict.text.isEmpty || _gIncome.text.isEmpty || _gIdType.isEmpty ||
        _gLocation.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all guarantor fields')));
      return;
    }
    if (_guarantorBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Guarantor photo required')));
      return;
    }
    final targetBranch = _branchId ?? appState.activeBranchId;
    if (targetBranch == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assign a branch to this customer')));
      return;
    }
    appState.customers.add(Customer(
      id: appState.nextCustomerIdFor(targetBranch),
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      phone: _phone.text.trim(),
      district: _district.text.trim(),
      monthlyIncome: num.tryParse(_income.text) ?? 0,
      occupation: _occupation.text.trim(),
      placeOfWork: _placeOfWork.text.trim(),
      idType: _idType,
      idNumber: _idNumber.text.trim(),
      email: _email.text.trim(),
      photo: _photoBytes,
      guarantorFirstName: _gFirstName.text.trim(),
      guarantorLastName: _gLastName.text.trim(),
      guarantorPhone: _gPhone.text.trim(),
      guarantorDistrict: _gDistrict.text.trim(),
      guarantorIncome: num.tryParse(_gIncome.text) ?? 0,
      guarantorOccupation: _gOccupation.text.trim(),
      guarantorPlaceOfWork: _gPlaceOfWork.text.trim(),
      guarantorIdType: _gIdType,
      guarantorIdNumber: _gIdNumber.text.trim(),
      guarantorEmail: _gEmail.text.trim(),
      guarantorLocation: _gLocation.text.trim(),
      guarantorPhoto: _guarantorBytes,
      branchId: targetBranch,
    ));
    for (final c in [_firstName, _lastName, _phone, _district, _income,
      _occupation, _placeOfWork, _idNumber, _email,
      _gFirstName, _gLastName, _gPhone, _gDistrict, _gIncome,
      _gOccupation, _gPlaceOfWork, _gIdNumber, _gEmail, _gLocation]) {
      c.clear();
    }
    setState(() {
      _idType = ''; _gIdType = '';
      _photoBytes = null; _guarantorBytes = null; _branchId = null;
    });
    appState.refresh();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Customer registered')));
  }

  void _deleteCustomer(int id, int? branchId) {
    final cust = appState.customers.firstWhere(
        (c) => c.id == id && c.branchId == branchId);
    final custLoans = appState.loans.where((l) =>
        l.customerId == id && l.branchId == branchId).toList();
    final canDelete = custLoans.isEmpty || custLoans.every((l) => l.status == 'paid');
    if (!canDelete) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot delete — has active loans')));
      return;
    }
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Delete customer?'),
      content: Text('Delete ${cust.fullName} and all their loan records?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: () {
          appState.loans.removeWhere((l) =>
              l.customerId == id && l.branchId == branchId);
          appState.customers.removeWhere((c) =>
              c.id == id && c.branchId == branchId);
          appState.refresh();
          Navigator.pop(context);
        }, child: const Text('Delete', style: TextStyle(color: C.danger))),
      ],
    ));
  }

  void _history(Customer c) {
    final custLoans = appState.loans.where((l) =>
        l.customerId == c.id && l.branchId == c.branchId).toList();
    showDialog(context: context, builder: (_) => _CustomerHistoryDialog(
        customer: c, custLoans: custLoans));
  }

  @override
  Widget build(BuildContext context) {
    final canRegister = Role.canRegisterCustomer(appState.currentRole);
    final canDelete = Role.canDeleteCustomer(appState.currentRole);

    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) {
        final q = _searchCtrl.text.toLowerCase().trim();
        final filtered = appState.visibleCustomers.where((c) =>
        q.isEmpty || c.fullName.toLowerCase().contains(q) ||
            c.phone.contains(q)).toList();

        return PageWrap(children: [
          if (canRegister) ...[
            SectionTitle('👤', 'Register New Customer'),
            SectionCard(
              title: 'Customer Details',
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PhotoPicker(
                      label: 'Customer Photo *',
                      bytes: _photoBytes,
                      onPick: () => _pickPhoto(isGuarantor: false),
                      onClear: () => _clearPhoto(isGuarantor: false),
                    ),
                    const SizedBox(width: 40),
                    _PhotoPicker(
                      label: 'Guarantor Photo *',
                      bytes: _guarantorBytes,
                      onPick: () => _pickPhoto(isGuarantor: true),
                      onClear: () => _clearPhoto(isGuarantor: true),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _f('First Name *', _firstName),
                  _f('Last Name *', _lastName),
                  _f('Phone *', _phone, keyboard: TextInputType.phone),
                  _f('District *', _district),
                  _f('Monthly Income (UGX) *', _income, keyboard: TextInputType.number),
                  _f('Occupation *', _occupation),
                  _f('Place of Work *', _placeOfWork),
                  SizedBox(width: 200, child: DropdownButtonFormField<String>(
                    initialValue: _idType.isEmpty ? null : _idType,
                    decoration: const InputDecoration(labelText: 'ID Type *'),
                    items: const [
                      DropdownMenuItem(value: 'National ID', child: Text('National ID')),
                      DropdownMenuItem(value: 'Passport', child: Text('Passport')),
                      DropdownMenuItem(value: 'Driving License', child: Text('Driving License')),
                      DropdownMenuItem(value: 'Voter ID', child: Text('Voter ID')),
                    ],
                    onChanged: (v) => setState(() => _idType = v ?? ''),
                  )),
                  _f('ID Number *', _idNumber),
                  _f('Email', _email, keyboard: TextInputType.emailAddress),
                  SizedBox(width: 200, child: DropdownButtonFormField<int>(
                    initialValue: _branchId ?? appState.activeBranchId,
                    decoration: const InputDecoration(labelText: 'Branch *'),
                    items: appState.branches
                        .map((b) => DropdownMenuItem(value: b.id, child: Text(b.name)))
                        .toList(),
                    onChanged: (v) => setState(() => _branchId = v),
                  )),
                ]),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 12),
                const Text('🤝 Guarantor — full details',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _f('Guarantor First Name *', _gFirstName),
                  _f('Guarantor Last Name *', _gLastName),
                  _f('Guarantor Phone *', _gPhone, keyboard: TextInputType.phone),
                  _f('Guarantor District *', _gDistrict),
                  _f('Guarantor Monthly Income (UGX) *', _gIncome,
                      keyboard: TextInputType.number),
                  _f('Guarantor Occupation *', _gOccupation),
                  _f('Guarantor Place of Work *', _gPlaceOfWork),
                  SizedBox(width: 200, child: DropdownButtonFormField<String>(
                    initialValue: _gIdType.isEmpty ? null : _gIdType,
                    decoration: const InputDecoration(labelText: 'ID Type *'),
                    items: const [
                      DropdownMenuItem(value: 'National ID', child: Text('National ID')),
                      DropdownMenuItem(value: 'Passport', child: Text('Passport')),
                      DropdownMenuItem(value: 'Driving License', child: Text('Driving License')),
                      DropdownMenuItem(value: 'Voter ID', child: Text('Voter ID')),
                    ],
                    onChanged: (v) => setState(() => _gIdType = v ?? ''),
                  )),
                  _f('Guarantor ID Number *', _gIdNumber),
                  _f('Guarantor Email', _gEmail, keyboard: TextInputType.emailAddress),
                  _f('Guarantor Location *', _gLocation, width: 260),
                ]),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _register,
                  icon: const Icon(Icons.person_add),
                  label: const Text('Register Customer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: C.primary, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                ),
              ]),
            ),
          ],
          SectionTitle('👥', 'All Customers'),
          SectionCard(
            title: '${filtered.length} customer(s)',
            child: Column(children: [
              TextField(
                controller: _searchCtrl,
                decoration: const InputDecoration(
                  hintText: 'Search by name or phone...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              if (filtered.isEmpty)
                const Padding(padding: EdgeInsets.all(20),
                    child: Text('No customers found',
                        style: TextStyle(color: C.textFaint)))
              else
                SizedBox(
                  width: double.infinity,
                  child: DataTable(columnSpacing: 20, columns: [
                    const DataColumn(label: Text('PHOTO')),
                    const DataColumn(label: Text('ID')),
                    const DataColumn(label: Text('NAME')),
                    const DataColumn(label: Text('PHONE')),
                    const DataColumn(label: Text('DISTRICT')),
                    const DataColumn(label: Text('BRANCH')),
                    const DataColumn(label: Text('INCOME')),
                    const DataColumn(label: Text('PENDING')),
                    DataColumn(label: Text(canDelete ? 'ACTIONS' : 'HISTORY')),
                  ], rows: filtered.map((c) {
                    final pending = appState.loans.where((l) =>
                    l.customerId == c.id && l.branchId == c.branchId &&
                        (l.status == 'pending' || l.status == 'overdue')).length;
                    final branchName = c.branchId == null
                        ? '—'
                        : appState.branches
                        .firstWhere((b) => b.id == c.branchId,
                        orElse: () => Branch(id: 0, name: '—', location: ''))
                        .name;
                    return DataRow(cells: [
                      DataCell(c.photo != null
                          ? ClipOval(child: Image.memory(c.photo!,
                          width: 40, height: 40, fit: BoxFit.cover))
                          : const Icon(Icons.person, size: 32, color: C.textFaint)),
                      DataCell(Text('${c.id}')),
                      DataCell(Text(c.fullName,
                          style: const TextStyle(fontWeight: FontWeight.w600))),
                      DataCell(Text(c.phone)),
                      DataCell(Text(c.district)),
                      DataCell(Text(branchName)),
                      DataCell(Text('UGX ${fmt(c.monthlyIncome)}')),
                      DataCell(Text('$pending')),
                      DataCell(Row(children: [
                        TextButton.icon(
                          onPressed: () => _history(c),
                          icon: const Icon(Icons.history, size: 14),
                          label: const Text('History'),
                        ),
                        if (canDelete)
                          IconButton(
                            icon: const Icon(Icons.delete, size: 16, color: C.danger),
                            onPressed: () => _deleteCustomer(c.id, c.branchId),
                          ),
                      ])),
                    ]);
                  }).toList()),
                ),
            ]),
          ),
        ]);
      },
    );
  }

  Widget _f(String label, TextEditingController c,
      {double width = 200, TextInputType? keyboard}) {
    return SizedBox(
      width: width,
      child: TextField(controller: c, keyboardType: keyboard,
          decoration: InputDecoration(labelText: label)),
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  final String label;
  final Uint8List? bytes;
  final VoidCallback onPick;
  final VoidCallback onClear;
  const _PhotoPicker({required this.label, required this.bytes,
    required this.onPick, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Stack(children: [
        InkWell(
          onTap: onPick,
          borderRadius: BorderRadius.circular(75),
          child: Container(
            width: 130, height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFAFBFC),
              border: Border.all(color: C.border, width: 2),
            ),
            child: bytes == null
                ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_file, size: 36, color: C.textFaint),
                  SizedBox(height: 4),
                  Text('Tap to upload',
                      style: TextStyle(fontSize: 11, color: C.textFaint)),
                ])
                : ClipOval(
                child: Image.memory(bytes!,
                    fit: BoxFit.cover, width: 130, height: 130)),
          ),
        ),
        if (bytes != null)
          Positioned(
            right: 0, bottom: 0,
            child: InkWell(
              onTap: onClear,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                    color: C.danger, shape: BoxShape.circle),
                child: const Icon(Icons.close, color: Colors.white, size: 14),
              ),
            ),
          ),
      ]),
      const SizedBox(height: 8),
      Row(mainAxisSize: MainAxisSize.min, children: [
        TextButton.icon(
          onPressed: onPick,
          icon: const Icon(Icons.upload_file, size: 16),
          label: const Text('Upload Photo'),
          style: TextButton.styleFrom(
            foregroundColor: C.primary,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ]),
    ]);
  }
}

// ─── Customer History Dialog ─────────────────────────────────────────────
class _CustomerHistoryDialog extends StatefulWidget {
  final Customer customer;
  final List<Loan> custLoans;
  const _CustomerHistoryDialog({required this.customer, required this.custLoans});

  @override
  State<_CustomerHistoryDialog> createState() => _CustomerHistoryDialogState();
}

class _CustomerHistoryDialogState extends State<_CustomerHistoryDialog> {
  // Build a full ledger: loan disbursals + expected installments + actual payments.
  // Each entry: {date, kind: 'loan'|'installment'|'payment',
  //              loan, payment?, installmentIndex?, emiAmount?, isPastDue?,
  //              borrowedRunning, balanceAfter}
  List<Map<String, dynamic>> _buildLedger() {
    final events = <Map<String, dynamic>>[];

    for (final l in widget.custLoans) {
      // 1) Loan disbursal event
      DateTime loanStart;
      try {
        final p = l.loanDate.split('-');
        loanStart = DateTime(int.parse(p[0]), int.parse(p[1]), int.parse(p[2]));
      } catch (_) {
        loanStart = DateTime.now();
      }
      events.add({
        'date': loanStart,
        'kind': 'loan',
        'loan': l,
        'payment': null,
        'sortKey': 0,
      });

      // 2) Expected installment schedule
      // Total number of installments = tenure (months) × periods-per-year / 12.
      int periodsPerYear;
      switch (l.frequency) {
        case 'Daily': periodsPerYear = 365; break;
        case 'Weekly': periodsPerYear = 52; break;
        default: periodsPerYear = 12;
      }
      final totalPeriods = (l.tenure * (periodsPerYear / 12)).round();
      final daysPerPeriod = (365 / periodsPerYear).round();
      for (int i = 1; i <= totalPeriods; i++) {
        final due = loanStart.add(Duration(days: i * daysPerPeriod));
        events.add({
          'date': due,
          'kind': 'installment',
          'loan': l,
          'payment': null,
          'installmentIndex': i,
          'emiAmount': l.emi,
          'isPastDue': DateTime.now().isAfter(due),
          'sortKey': 1,
        });
      }

      // 3) Actual payments
      for (final p in l.payments) {
        events.add({
          'date': p.timestamp,
          'kind': 'payment',
          'loan': l,
          'payment': p,
          'sortKey': 2,
        });
      }
    }

    // Sort oldest → newest to compute running totals correctly.
    events.sort((a, b) {
      final cmp = (a['date'] as DateTime).compareTo(b['date'] as DateTime);
      if (cmp != 0) return cmp;
      return (a['sortKey'] as int).compareTo(b['sortKey'] as int);
    });

    // Running borrowed total and rolling balance per loan.
    num runningBorrowed = 0;
    final computed = <Map<String, dynamic>>[];
    for (final e in events) {
      final kind = e['kind'] as String;
      final loan = e['loan'] as Loan;
      if (kind == 'loan') {
        runningBorrowed += loan.amount;
      }
      final balanceAfter = AppState.outstandingBalance(loan);
      computed.add({
        ...e,
        'borrowedRunning': runningBorrowed,
        'balanceAfter': balanceAfter,
      });
    }
    // Present newest → oldest.
    computed.sort((a, b) {
      final cmp = (b['date'] as DateTime).compareTo(a['date'] as DateTime);
      if (cmp != 0) return cmp;
      return (b['sortKey'] as int).compareTo(a['sortKey'] as int);
    });
    return computed;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final width = (screen.width - 80).clamp(560.0, 1150.0);
    final height = (screen.height - 120).clamp(460.0, 720.0);

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width, maxHeight: height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: C.border)),
              ),
              child: Row(children: [
                Expanded(
                  child: Text('📋 History — ${widget.customer.fullName}',
                      style: const TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w700, color: C.textPrimary)),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ]),
            ),
            // Ledger (fills most of the dialog)
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: C.border)),
                ),
                child: _ledger(),
              ),
            ),
            // Loan summary drill-down
            Expanded(
              flex: 2,
              child: _loansTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ledger() {
    final rows = _buildLedger();
    if (rows.isEmpty) {
      return const Center(
          child: Text('No transactions yet', style: TextStyle(color: C.textFaint)));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Icon(Icons.receipt_long, size: 16, color: C.primary),
          const SizedBox(width: 6),
          Text('Transaction Ledger (${rows.length} entries)',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 6),
        Expanded(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                headingRowHeight: 32,
                dataRowMinHeight: 32,
                dataRowMaxHeight: 42,
                headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                columns: const [
                  DataColumn(label: Text('DATE',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700))),
                  DataColumn(label: Text('TIME',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700))),
                  DataColumn(label: Text('AMOUNT BORROWED',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700))),
                  DataColumn(label: Text('AMOUNT PAID',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700))),
                  DataColumn(label: Text('OUTSTANDING BALANCE',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700))),
                ],
                rows: rows.map((r) {
                  final d = r['date'] as DateTime;
                  final kind = r['kind'] as String;
                  final loan = r['loan'] as Loan;
                  final payment = r['payment'] as Payment?;
                  final borrowedRunning = r['borrowedRunning'] as num;
                  final balance = r['balanceAfter'] as num;

                  // Amount Borrowed column
                  String borrowedText = '—';
                  Color borrowedColor = C.textMuted;
                  if (kind == 'loan') {
                    borrowedText = 'UGX ${fmt(loan.amount)}';
                    borrowedColor = C.info;
                  }

                  // Amount Paid column
                  String paidText = '—';
                  Color paidColor = C.textMuted;
                  FontWeight paidWeight = FontWeight.normal;
                  if (kind == 'payment') {
                    paidText = 'UGX ${fmt(payment!.amount)}';
                    paidColor = C.success;
                    paidWeight = FontWeight.w700;
                  } else if (kind == 'installment') {
                    final idx = r['installmentIndex'] as int;
                    final due = r['isPastDue'] as bool;
                    paidText = 'Due: UGX ${fmt(loan.emi)} (#$idx)';
                    paidColor = due ? C.danger : C.textMuted;
                  }

                  return DataRow(cells: [
                    DataCell(Text(
                        '${d.day.toString().padLeft(2, '0')}/'
                            '${d.month.toString().padLeft(2, '0')}/${d.year}',
                        style: const TextStyle(fontSize: 11.5))),
                    DataCell(Text(
                        kind == 'installment'
                            ? '—'
                            : '${d.hour.toString().padLeft(2, '0')}:'
                            '${d.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 11.5))),
                    DataCell(Text(borrowedText,
                        style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: kind == 'loan'
                                ? FontWeight.w700 : FontWeight.normal,
                            color: borrowedColor))),
                    DataCell(Text(paidText,
                        style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: paidWeight,
                            color: paidColor))),
                    DataCell(Text('UGX ${fmt(balance)}',
                        style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: balance > 0 ? C.danger : C.success))),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loansTab() {
    if (widget.custLoans.isEmpty) {
      return const Center(child: Text('No loans yet'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: widget.custLoans.length,
      itemBuilder: (_, i) {
        final l = widget.custLoans[i];
        final bal = AppState.outstandingBalance(l);
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Loan #${l.id}',
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    StatusBadge(l.status),
                  ],
                ),
                const Divider(),
                Text('Borrowed: UGX ${fmt(l.amount)}  •  Date: ${prettyDate(l.loanDate)}'),
                Text('EMI: UGX ${fmt(l.emi)} ${AppState.freqLabel(l.frequency)}',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: C.info)),
                Text('Outstanding: UGX ${fmt(bal)}',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: bal > 0 ? C.danger : C.success)),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  4. LOANS
// ═══════════════════════════════════════════════════════════════════════════
class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});
  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  final _customerSearch = TextEditingController();
  Customer? _selectedCustomer;
  List<Customer> _suggestions = [];

  final _businessName = TextEditingController();
  final _businessDistrict = TextEditingController();
  final _businessLocation = TextEditingController();
  final _businessNearby = TextEditingController();
  final _loanAmountFigures = TextEditingController();
  final _loanAmountWords = TextEditingController();
  final _processingFee = TextEditingController();
  final _securityProperty = TextEditingController();
  final _securityVehicle = TextEditingController();
  final _securityVehicleReg = TextEditingController();
  final _securityNIN = TextEditingController();
  final _loanAmount = TextEditingController();
  final _interestRate = TextEditingController();
  final _loanTenure = TextEditingController();
  String _frequency = '';
  String _approverName = '';
  String _approverTitle = '';
  num _previewEmi = 0;

  @override
  void dispose() {
    for (final c in [_customerSearch, _businessName, _businessDistrict,
      _businessLocation, _businessNearby, _loanAmountFigures, _loanAmountWords,
      _processingFee, _securityProperty, _securityVehicle, _securityVehicleReg,
      _securityNIN, _loanAmount, _interestRate, _loanTenure]) { c.dispose(); }
    super.dispose();
  }

  void _searchCustomer(String q) {
    if (q.length < 2) { setState(() => _suggestions = []); return; }
    final s = q.toLowerCase();
    setState(() {
      _suggestions = appState.visibleCustomers.where((c) =>
      c.fullName.toLowerCase().contains(s) || c.phone.contains(s)).toList();
    });
  }

  void _selectCustomer(Customer c) {
    setState(() {
      _selectedCustomer = c;
      _customerSearch.text = c.fullName;
      _suggestions = [];
    });
  }

  void _clearCustomer() {
    setState(() {
      _selectedCustomer = null;
      _customerSearch.clear();
      _suggestions = [];
    });
  }

  void _updatePreview() {
    final a = num.tryParse(_loanAmount.text) ?? 0;
    final t = int.tryParse(_loanTenure.text) ?? 0;
    final rate = num.tryParse(_interestRate.text) ?? 0;
    if (a > 0 && t > 0 && rate > 0 && _frequency.isNotEmpty) {
      setState(() => _previewEmi = AppState.calculatePayment(a, rate, t, _frequency));
    } else {
      setState(() => _previewEmi = 0);
    }
  }

  void _applyLoan() {
    if (_selectedCustomer == null) { _snack('Select a customer first'); return; }
    final amount = num.tryParse(_loanAmount.text) ?? 0;
    final tenure = int.tryParse(_loanTenure.text) ?? 0;
    final rate = num.tryParse(_interestRate.text) ?? 0;
    final fee = num.tryParse(_processingFee.text) ?? 0;
    if (amount <= 0 || tenure <= 0 || rate <= 0 || _frequency.isEmpty ||
        _approverName.isEmpty || _approverTitle.isEmpty ||
        _businessName.text.isEmpty || _loanAmountFigures.text.isEmpty) {
      _snack('Fill all required fields (interest & fee required)');
      return;
    }
    final emi = AppState.calculatePayment(amount, rate, tenure, _frequency);
    final iso = isoDate(DateTime.now());

    appState.loans.add(Loan(
      id: appState.nextLoanIdFor(_selectedCustomer!.branchId),
      customerId: _selectedCustomer!.id,
      customerName: _selectedCustomer!.fullName,
      amount: amount, rate: rate, tenure: tenure, emi: emi,
      processingFee: fee,
      status: 'pending', frequency: _frequency, loanDate: iso,
      approverName: _approverName, approverTitle: _approverTitle,
      businessName: _businessName.text,
      businessDistrict: _businessDistrict.text,
      businessLocation: _businessLocation.text,
      businessNearby: _businessNearby.text,
      loanAmountFigures: num.tryParse(_loanAmountFigures.text) ?? 0,
      loanAmountWords: _loanAmountWords.text,
      securityProperty: _securityProperty.text,
      securityVehicle: _securityVehicle.text,
      securityVehicleReg: _securityVehicleReg.text,
      securityNIN: _securityNIN.text,
      branchId: _selectedCustomer!.branchId,
    ));

    for (final c in [_businessName, _businessDistrict, _businessLocation,
      _businessNearby, _loanAmountFigures, _loanAmountWords, _processingFee,
      _securityProperty, _securityVehicle, _securityVehicleReg, _securityNIN,
      _loanAmount, _interestRate, _loanTenure]) { c.clear(); }
    setState(() {
      _frequency = ''; _approverName = ''; _approverTitle = '';
      _selectedCustomer = null; _customerSearch.clear(); _previewEmi = 0;
    });
    appState.refresh();
    _snack('✅ Loan applied — awaiting payment');
  }

  void _snack(String msg) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    final canApply = Role.canApplyLoan(appState.currentRole);

    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) {
        final allLoans = appState.visibleLoans.reversed.toList();

        return PageWrap(children: [
          if (canApply) ...[
            SectionTitle('📄', 'Apply for Loan'),
            SectionCard(
              title: 'Loan Application Form',
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TextField(
                  controller: _customerSearch,
                  decoration: const InputDecoration(
                    labelText: 'Search Customer *',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _searchCustomer,
                ),
                if (_suggestions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: C.border),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: _suggestions.take(5).map((c) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.person, size: 18),
                        title: Text(c.fullName),
                        subtitle: Text(c.phone),
                        onTap: () => _selectCustomer(c),
                      )).toList(),
                    ),
                  ),
                if (_selectedCustomer != null)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(children: [
                      const Icon(Icons.check_circle, color: C.success, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Selected: ${_selectedCustomer!.fullName}')),
                      IconButton(
                        icon: const Icon(Icons.close, size: 18, color: C.danger),
                        onPressed: _clearCustomer,
                      ),
                    ]),
                  ),
                const SizedBox(height: 20),
                const Divider(), const SizedBox(height: 8),
                const Text('🏪 Business Details',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _f('Name of Business *', _businessName),
                  _f('Business District *', _businessDistrict),
                  _f('Business Location *', _businessLocation),
                  _f('Nearby Landmark *', _businessNearby),
                ]),
                const SizedBox(height: 20),
                const Divider(), const SizedBox(height: 8),
                const Text('📝 Particulars of Loan',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _f('Amount (Figures) *', _loanAmountFigures,
                      keyboard: TextInputType.number),
                  _f('Amount (Words) *', _loanAmountWords, width: 320),
                ]),
                const SizedBox(height: 20),
                const Divider(), const SizedBox(height: 8),
                const Text('🛡️ Security Details',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _f('Property Name(s) *', _securityProperty),
                  _f('Vehicle Make & Model', _securityVehicle),
                  _f('Vehicle Reg. No.', _securityVehicleReg),
                  _f('National ID (NIN) *', _securityNIN),
                ]),
                const SizedBox(height: 20),
                const Divider(), const SizedBox(height: 8),
                const Text('💳 Loan Terms',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _f('Amount (UGX) *', _loanAmount,
                      keyboard: TextInputType.number, onChanged: (_) => _updatePreview()),
                  _f('Processing Fee (UGX) *', _processingFee,
                      keyboard: TextInputType.number),
                  _f('Interest Rate (%) *', _interestRate,
                      keyboard: TextInputType.number, onChanged: (_) => _updatePreview()),
                  _f('Tenure (months) *', _loanTenure,
                      keyboard: TextInputType.number, onChanged: (_) => _updatePreview()),
                  SizedBox(width: 200, child: DropdownButtonFormField<String>(
                    initialValue: _frequency.isEmpty ? null : _frequency,
                    decoration: const InputDecoration(labelText: 'Frequency *'),
                    items: const [
                      DropdownMenuItem(value: 'Daily', child: Text('Daily')),
                      DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                      DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                    ],
                    onChanged: (v) {
                      setState(() => _frequency = v ?? '');
                      _updatePreview();
                    },
                  )),
                  SizedBox(width: 260, child: DropdownButtonFormField<String>(
                    initialValue: _approverName.isEmpty ? null : _approverName,
                    decoration: const InputDecoration(labelText: 'Approver Name *'),
                    items: const [
                      DropdownMenuItem(value: 'Sarah Adong (Manager)',
                          child: Text('Sarah Adong (Manager)')),
                      DropdownMenuItem(value: 'John Ochen (Supervisor)',
                          child: Text('John Ochen (Supervisor)')),
                      DropdownMenuItem(value: 'Grace Auma (Cashier)',
                          child: Text('Grace Auma (Cashier)')),
                      DropdownMenuItem(value: 'Peter Otim (Field Officer)',
                          child: Text('Peter Otim (Field Officer)')),
                    ],
                    onChanged: (v) => setState(() => _approverName = v ?? ''),
                  )),
                  SizedBox(width: 200, child: DropdownButtonFormField<String>(
                    initialValue: _approverTitle.isEmpty ? null : _approverTitle,
                    decoration: const InputDecoration(labelText: 'Approver Title *'),
                    items: const [
                      DropdownMenuItem(value: 'Manager', child: Text('Manager')),
                      DropdownMenuItem(value: 'Supervisor', child: Text('Supervisor')),
                      DropdownMenuItem(value: 'Cashier', child: Text('Cashier')),
                      DropdownMenuItem(value: 'Field Officer', child: Text('Field Officer')),
                    ],
                    onChanged: (v) => setState(() => _approverTitle = v ?? ''),
                  )),
                ]),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    const Text('Calculated Payment: ',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('UGX ${fmt(_previewEmi)}',
                        style: const TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 18, color: C.primary)),
                    const SizedBox(width: 6),
                    Text(AppState.freqLabel(_frequency),
                        style: const TextStyle(color: C.textFaint, fontSize: 12)),
                  ]),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _applyLoan,
                  icon: const Icon(Icons.check),
                  label: const Text('Apply Loan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: C.success, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  ),
                ),
              ]),
            ),
          ],
          SectionTitle('📄', 'All Loans'),
          SectionCard(
            title: '${allLoans.length} loan(s)',
            child: allLoans.isEmpty
                ? const Padding(padding: EdgeInsets.all(20),
                child: Text('No loans', style: TextStyle(color: C.textFaint)))
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(columnSpacing: 20, columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('CUSTOMER')),
                DataColumn(label: Text('BORROWED')),
                DataColumn(label: Text('FEE')),
                DataColumn(label: Text('RATE')),
                DataColumn(label: Text('FREQ')),
                DataColumn(label: Text('EMI')),
                DataColumn(label: Text('BALANCE')),
                DataColumn(label: Text('STATUS')),
              ], rows: allLoans.map((l) {
                final bal = AppState.outstandingBalance(l);
                return DataRow(cells: [
                  DataCell(Text('${l.id}')),
                  DataCell(Text(l.customerName,
                      style: const TextStyle(fontWeight: FontWeight.w600))),
                  DataCell(Text('UGX ${fmt(l.amount)}')),
                  DataCell(Text('UGX ${fmt(l.processingFee)}',
                      style: const TextStyle(color: C.info))),
                  DataCell(Text('${l.rate}%')),
                  DataCell(FreqBadge(l.frequency)),
                  DataCell(Text('UGX ${fmt(l.emi)}')),
                  DataCell(Text('UGX ${fmt(bal)}')),
                  DataCell(StatusBadge(l.status)),
                ]);
              }).toList()),
            ),
          ),
        ]);
      },
    );
  }

  Widget _f(String label, TextEditingController c,
      {double width = 220, TextInputType? keyboard, Function(String)? onChanged}) {
    return SizedBox(
      width: width,
      child: TextField(controller: c, keyboardType: keyboard,
          onChanged: onChanged,
          decoration: InputDecoration(labelText: label)),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  5. PAYMENTS
// ═══════════════════════════════════════════════════════════════════════════
class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) {
        final canRecord = Role.canRecordPayment(appState.currentRole);
        final pending = appState.visibleLoans.where((l) =>
        l.status == 'pending' || l.status == 'overdue').toList();

        return PageWrap(children: [
          SectionTitle('💰', 'Record Payment'),
          if (canRecord)
            SectionCard(
              title: 'Pending Loans',
              child: pending.isEmpty
                  ? const Padding(padding: EdgeInsets.all(20),
                  child: Text('No pending loans',
                      style: TextStyle(color: C.textFaint)))
                  : SizedBox(
                width: double.infinity,
                child: DataTable(columnSpacing: 32, columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('CUSTOMER')),
                  DataColumn(label: Text('EMI')),
                  DataColumn(label: Text('BORROWED')),
                  DataColumn(label: Text('BALANCE')),
                  DataColumn(label: Text('STATUS')),
                  DataColumn(label: Text('ACTION')),
                ], rows: pending.map((l) {
                  final bal = AppState.outstandingBalance(l);
                  return DataRow(cells: [
                    DataCell(Text('#${l.id}')),
                    DataCell(Text(l.customerName,
                        style: const TextStyle(fontWeight: FontWeight.w600))),
                    DataCell(Text('UGX ${fmt(l.emi)}')),
                    DataCell(Text('UGX ${fmt(l.amount)}')),
                    DataCell(Text('UGX ${fmt(bal)}')),
                    DataCell(StatusBadge(l.status)),
                    DataCell(ElevatedButton(
                      onPressed: () => _openPayment(context, l),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: C.primary, foregroundColor: Colors.white,
                      ),
                      child: const Text('Pay'),
                    )),
                  ]);
                }).toList()),
              ),
            )
          else
            const SectionCard(
              title: 'Access restricted',
              child: Padding(padding: EdgeInsets.all(20),
                  child: Text('Your role cannot record payments.')),
            ),
        ]);
      },
    );
  }

  void _openPayment(BuildContext context, Loan loan) {
    final amountCtrl = TextEditingController(
        text: '${AppState.outstandingBalance(loan)}');
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text('💵 Record Payment — #${loan.id}'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('${loan.customerName} · ${loan.frequency}'),
        const SizedBox(height: 8),
        Text('EMI: UGX ${fmt(loan.emi)}   |   Balance: UGX ${fmt(AppState.outstandingBalance(loan))}'),
        const SizedBox(height: 12),
        TextField(
          controller: amountCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Amount (UGX)'),
        ),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: C.success, foregroundColor: Colors.white),
          onPressed: () {
            final amt = num.tryParse(amountCtrl.text) ?? 0;
            if (amt <= 0) return;
            loan.payments.add(Payment(amt, DateTime.now()));
            final bal = AppState.outstandingBalance(loan);
            if (bal <= 0) {
              loan.status = 'paid';
            } else {
              loan.status = AppState.overdueDays(loan) > 0 ? 'overdue' : 'pending';
            }
            appState.refresh();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Payment recorded')));
          },
          child: const Text('Confirm'),
        ),
      ],
    ));
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  6. REPORTS
// ═══════════════════════════════════════════════════════════════════════════
class ReportsScreen extends StatelessWidget {
  final String activeReport;
  const ReportsScreen({super.key, this.activeReport = 'pending'});

  @override
  Widget build(BuildContext context) {
    if (!Role.canViewReports(appState.currentRole)) {
      return const PageWrap(children: [
        SectionCard(title: 'Access Restricted',
          child: Padding(padding: EdgeInsets.all(20),
              child: Text('Your role cannot view reports.'))),
      ]);
    }
    final canDaily = Role.canViewDaily(appState.currentRole);
    final key = (activeReport == 'daily' && !canDaily) ? 'pending' : activeReport;

    Widget body;
    switch (key) {
      case 'overdue':
        body = _CategoryReportBody(status: 'overdue', showDays: true, paidMode: false);
        break;
      case 'paid':
        body = _CategoryReportBody(status: 'paid', showDays: false, paidMode: true);
        break;
      case 'daily':
        body = const _DailyWorkAccountabilityBody();
        break;
      case 'pending':
      default:
        body = _CategoryReportBody(status: 'pending', showDays: false, paidMode: false);
    }

    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) => PageWrap(children: [
        SectionTitle('📊', 'Reports'),
        body,
      ]),
    );
  }
}

class _CategoryReportBody extends StatelessWidget {
  final String status;
  final bool showDays;
  final bool paidMode;
  const _CategoryReportBody({
    required this.status,
    required this.showDays,
    required this.paidMode,
  });

  @override
  Widget build(BuildContext context) {
    final list = appState.visibleLoans.where((l) => l.status == status).toList();
    final title = status == 'pending'
        ? '⏳ Pending Loans'
        : status == 'overdue'
        ? '⚠️ Overdue Loans'
        : '✅ Paid Loans';

    return SectionCard(
      title: '$title — ${list.length} loan(s)',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => _printReport(context, status),
            icon: const Icon(Icons.print),
            label: const Text('Print'),
            style: ElevatedButton.styleFrom(
                backgroundColor: C.info, foregroundColor: Colors.white),
          ),
        ),
        const SizedBox(height: 12),
        _table(list),
      ]),
    );
  }

  Widget _table(List<Loan> list) {
    if (list.isEmpty) {
      return const Padding(padding: EdgeInsets.all(20),
          child: Text('No loans in this category',
              style: TextStyle(color: C.textFaint)));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columnSpacing: 20, columns: [
        const DataColumn(label: Text('CUSTOMER')),
        const DataColumn(label: Text('PHONE')),
        const DataColumn(label: Text('BORROWED')),
        const DataColumn(label: Text('FEE')),
        const DataColumn(label: Text('FREQ')),
        const DataColumn(label: Text('EMI')),
        const DataColumn(label: Text('BALANCE')),
        if (showDays) const DataColumn(label: Text('DAYS OVERDUE')),
        if (paidMode) const DataColumn(label: Text('TOTAL PAID')),
      ], rows: list.map((l) {
        final cust = appState.customers.firstWhere((c) =>
        c.id == l.customerId && c.branchId == l.branchId,
            orElse: () => Customer(id: 0, firstName: '-', lastName: '',
                phone: '-', district: '', monthlyIncome: 0));
        return DataRow(cells: [
          DataCell(Text(l.customerName,
              style: const TextStyle(fontWeight: FontWeight.w600))),
          DataCell(Text(cust.phone)),
          DataCell(Text('UGX ${fmt(l.amount)}')),
          DataCell(Text('UGX ${fmt(l.processingFee)}',
              style: const TextStyle(color: C.info))),
          DataCell(FreqBadge(l.frequency)),
          DataCell(Text('UGX ${fmt(l.emi)}')),
          DataCell(Text('UGX ${fmt(AppState.outstandingBalance(l))}')),
          if (showDays)
            DataCell(Text('${AppState.overdueDays(l)} days',
                style: const TextStyle(color: C.danger, fontWeight: FontWeight.w700))),
          if (paidMode)
            DataCell(Text('UGX ${fmt(AppState.totalPaid(l))}')),
        ]);
      }).toList()),
    );
  }

  Future<void> _printReport(BuildContext context, String tab) async {
    try {
      final list = appState.visibleLoans.where((l) => l.status == tab).toList();
      final title = tab == 'pending'
          ? 'Pending Loans Report'
          : tab == 'overdue'
          ? 'Overdue Loans Report'
          : 'Paid Loans Report';

      final doc = pw.Document();
      doc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context ctx) => [
          pw.Header(
            level: 0,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('QUADRATIC FINANCIAL SERVICES',
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 4),
                pw.Text('Money Lending Management System',
                    style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
                pw.SizedBox(height: 2),
                pw.Text('Location: Arua, Uganda | Contact: +256 775 638 056',
                    style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                if (appState.activeBranch != null) ...[
                  pw.SizedBox(height: 2),
                  pw.Text('Branch: ${appState.activeBranch!.name}',
                      style: const pw.TextStyle(fontSize: 10, color: PdfColors.brown800)),
                ],
              ],
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Text(title,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Text('Generated: ${todayFormatted()}',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
          pw.SizedBox(height: 12),
          pw.Table.fromTextArray(
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold,
                color: PdfColors.white, fontSize: 10),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.brown800),
            cellStyle: const pw.TextStyle(fontSize: 9),
            cellAlignment: pw.Alignment.centerLeft,
            headers: [
              'Customer', 'Phone', 'Borrowed', 'Fee', 'Freq', 'EMI', 'Balance',
              if (tab == 'overdue') 'Days',
              if (tab == 'paid') 'Total Paid',
            ],
            data: list.map((l) {
              final cust = appState.customers.firstWhere(
                      (c) => c.id == l.customerId && c.branchId == l.branchId,
                  orElse: () => Customer(id: 0, firstName: '-', lastName: '',
                      phone: '-', district: '', monthlyIncome: 0));
              return <String>[
                l.customerName, cust.phone,
                'UGX ${fmt(l.amount)}', 'UGX ${fmt(l.processingFee)}', l.frequency,
                'UGX ${fmt(l.emi)}',
                'UGX ${fmt(AppState.outstandingBalance(l))}',
                if (tab == 'overdue') '${AppState.overdueDays(l)}',
                if (tab == 'paid') 'UGX ${fmt(AppState.totalPaid(l))}',
              ];
            }).toList(),
          ),
          pw.SizedBox(height: 20),
          pw.Text('© 2026 QUADRATIC FINANCIAL SERVICES — All Rights Reserved.',
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
        ],
      ));

      await Printing.layoutPdf(
        onLayout: (format) async => doc.save(),
        name: '$title ${todayFormatted()}',
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Print failed: $e')),
      );
    }
  }
}

// ─── Daily Work Accountability body ──────────────────────────────────────
class _DailyWorkAccountabilityBody extends StatefulWidget {
  const _DailyWorkAccountabilityBody();
  @override
  State<_DailyWorkAccountabilityBody> createState() => _DailyWorkAccountabilityBodyState();
}

class _DailyWorkAccountabilityBodyState extends State<_DailyWorkAccountabilityBody> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) {
        final dateStr = isoDate(_selectedDate);

        num cashCollected = 0;
        num loansDistributed = 0;
        num processingFees = 0;
        num expensesTotal = 0;

        for (final loan in appState.visibleLoans) {
          for (final p in loan.payments) {
            if (isoDate(p.timestamp) == dateStr) cashCollected += p.amount;
          }
          if (loan.loanDate == dateStr) {
            loansDistributed += loan.amount;
            processingFees += loan.processingFee;
          }
        }

        final todaysExpenses = appState.visibleExpenses
            .where((e) => e.date == dateStr).toList();
        for (final e in todaysExpenses) expensesTotal += e.amount;

        final banked = appState.bankedFor(dateStr);
        final bankedSet = appState.hasBanked(dateStr);

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SectionCard(
            title: '📅 Daily Work Accountability — ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            child: Row(children: [
              Expanded(
                child: Text(
                  'Accountability Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => _selectedDate = picked);
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Change Date'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: C.primary, foregroundColor: Colors.white),
              ),
            ]),
          ),
          LayoutBuilder(builder: (_, c) {
            final cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 500 ? 2 : 1);
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.0,
              children: [
                StatCard(label: 'Opening Balance (Est.)', value: 'UGX 0'),
                StatCard(label: 'Cash Collected', value: 'UGX ${fmt(cashCollected)}'),
                StatCard(label: 'Processing Fees', value: 'UGX ${fmt(processingFees)}'),
                StatCard(label: 'Loans Distributed', value: 'UGX ${fmt(loansDistributed)}'),
                StatCard(label: 'Expenses', value: 'UGX ${fmt(expensesTotal)}', negative: true),
                StatCard(
                  label: 'Amount Banked (manual)',
                  value: bankedSet ? 'UGX ${fmt(banked)}' : 'Not set',
                  change: 'Tap to enter',
                  onTap: () => _editBanked(dateStr, banked),
                ),
              ],
            );
          }),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Expenses for this Date',
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ElevatedButton.icon(
                onPressed: () => _addExpenseDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Record Expense'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: C.danger, foregroundColor: Colors.white),
              ),
              const SizedBox(height: 12),
              if (todaysExpenses.isEmpty)
                const Text('No expenses recorded for this date',
                    style: TextStyle(color: C.textFaint, fontSize: 12))
              else
                SizedBox(
                  width: double.infinity,
                  child: DataTable(columnSpacing: 24, columns: const [
                    DataColumn(label: Text('DATE')),
                    DataColumn(label: Text('REASON')),
                    DataColumn(label: Text('AMOUNT')),
                  ], rows: todaysExpenses.map((e) => DataRow(cells: [
                    DataCell(Text(prettyDate(e.date))),
                    DataCell(Text(e.description)),
                    DataCell(Text('- UGX ${fmt(e.amount)}',
                        style: const TextStyle(color: C.danger,
                            fontWeight: FontWeight.w700))),
                  ])).toList()),
                ),
            ]),
          ),
        ]);
      },
    );
  }

  Future<void> _editBanked(String dateStr, num current) async {
    final ctrl = TextEditingController(text: current > 0 ? '$current' : '');
    await showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('Amount Banked — ${prettyDate(dateStr)}'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text(
          'This amount is entered manually by the manager for the selected date.',
          style: TextStyle(fontSize: 12, color: C.textMuted),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Amount (UGX)'),
          autofocus: true,
        ),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: C.primary, foregroundColor: Colors.white),
          onPressed: () {
            final v = num.tryParse(ctrl.text) ?? 0;
            if (v >= 0) {
              appState.setBanked(dateStr, v);
              Navigator.pop(ctx);
            }
          },
          child: const Text('Save'),
        ),
      ],
    ));
  }

  Future<void> _addExpenseDialog(BuildContext context) async {
    final dateCtrl = TextEditingController(text: isoDate(_selectedDate));
    final reasonCtrl = TextEditingController();
    final amountCtrl = TextEditingController();

    await showDialog(context: context, builder: (_) => StatefulBuilder(
      builder: (ctx, setS) => AlertDialog(
        title: const Text('Record Expense'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: dateCtrl,
            decoration: const InputDecoration(
              labelText: 'Date *', suffixIcon: Icon(Icons.calendar_today, size: 18),
            ),
            readOnly: true,
            onTap: () async {
              final cur = DateTime.tryParse(dateCtrl.text) ?? DateTime.now();
              final picked = await showDatePicker(
                context: ctx, initialDate: cur,
                firstDate: DateTime(2020), lastDate: DateTime.now(),
              );
              if (picked != null) setS(() => dateCtrl.text = isoDate(picked));
            },
          ),
          const SizedBox(height: 8),
          TextField(
            controller: reasonCtrl,
            decoration: const InputDecoration(labelText: 'Reason *'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: amountCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount (UGX) *'),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: C.primary, foregroundColor: Colors.white),
            onPressed: () {
              final amt = num.tryParse(amountCtrl.text) ?? 0;
              final dateIso = dateCtrl.text.trim();
              if (reasonCtrl.text.isNotEmpty && amt > 0 &&
                  DateTime.tryParse(dateIso) != null) {
                final targetBranch = appState.activeBranchId;
                appState.expenses.add(DailyExpense(
                  id: appState.nextExpenseIdFor(targetBranch),
                  date: dateIso,
                  description: reasonCtrl.text.trim(),
                  amount: amt,
                  branchId: targetBranch,
                ));
                appState.refresh();
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  7. BRANCHES
// ═══════════════════════════════════════════════════════════════════════════
class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  void _addBranchDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final locationCtrl = TextEditingController();

    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Add New Branch'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameCtrl,
            decoration: const InputDecoration(labelText: 'Branch Name *')),
        const SizedBox(height: 10),
        TextField(controller: locationCtrl,
            decoration: const InputDecoration(labelText: 'Location *')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: C.primary, foregroundColor: Colors.white),
          onPressed: () {
            if (nameCtrl.text.isEmpty || locationCtrl.text.isEmpty) return;
            final newId = appState.nextBranchId++;
            appState.branches.add(Branch(
              id: newId,
              name: nameCtrl.text.trim(),
              location: locationCtrl.text.trim(),
              manager: appState.currentUserName,
            ));
            appState._branchCustomerCounter[newId] = 1;
            appState._branchStaffCounter[newId] = 1;
            appState._branchLoanCounter[newId] = 1;
            appState._branchExpenseCounter[newId] = 1;
            appState.refresh();
            Navigator.pop(context);
          },
          child: const Text('Create'),
        ),
      ],
    ));
  }

  void _openBranch(BuildContext context, Branch b) {
    final wasInBranch = appState.activeBranchId != null;
    if (wasInBranch) {
      appState.enterBranch(b.id);
      Navigator.pop(context);
    } else {
      appState.enterBranch(b.id);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const BranchShell(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Role.canManageBranches(appState.currentRole)) {
      return const PageWrap(children: [
        SectionCard(
          title: 'Access Restricted',
          child: Padding(padding: EdgeInsets.all(20),
              child: Text('Only the Manager can manage branches.')),
        ),
      ]);
    }

    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) {
        return PageWrap(children: [
          SectionTitle('🏢', 'Branches'),
          SectionCard(
            title: '${appState.branches.length} branch(es) — every branch is independent',
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () => _addBranchDialog(context),
                  icon: const Icon(Icons.add_business),
                  label: const Text('Create Branch'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: C.primary, foregroundColor: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              if (appState.branches.isEmpty)
                const Padding(padding: EdgeInsets.all(20),
                    child: Text('No branches yet',
                        style: TextStyle(color: C.textFaint)))
              else
                SizedBox(
                  width: double.infinity,
                  child: DataTable(columnSpacing: 20, columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('BRANCH NAME')),
                    DataColumn(label: Text('LOCATION')),
                    DataColumn(label: Text('MANAGER')),
                    DataColumn(label: Text('CUSTOMERS')),
                    DataColumn(label: Text('LOANS')),
                    DataColumn(label: Text('STAFF')),
                    DataColumn(label: Text('OPEN')),
                  ], rows: appState.branches.map((b) {
                    final custCount = appState.customers
                        .where((c) => c.branchId == b.id).length;
                    final loanCount = appState.loans
                        .where((l) => l.branchId == b.id).length;
                    final staffCount = appState.staffList
                        .where((s) => s.branchId == b.id).length;
                    final isCurrent = appState.activeBranchId == b.id;
                    return DataRow(cells: [
                      DataCell(Text('${b.id}')),
                      DataCell(InkWell(
                        onTap: () => _openBranch(context, b),
                        child: Row(children: [
                          Text(b.name, style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: C.info,
                              decoration: TextDecoration.underline)),
                          if (isCurrent) ...[
                            const SizedBox(width: 6),
                            const Icon(Icons.check_circle, size: 14, color: C.success),
                          ] else
                            const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(Icons.open_in_new, size: 14, color: C.info),
                            ),
                        ]),
                      )),
                      DataCell(Text(b.location)),
                      DataCell(Text(b.manager)),
                      DataCell(Text('$custCount')),
                      DataCell(Text('$loanCount')),
                      DataCell(Text('$staffCount')),
                      DataCell(ElevatedButton.icon(
                        onPressed: () => _openBranch(context, b),
                        icon: const Icon(Icons.open_in_new, size: 14),
                        label: Text(isCurrent ? 'Entered' : 'Open'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isCurrent ? C.success : C.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      )),
                    ]);
                  }).toList()),
                ),
            ]),
          ),
        ]);
      },
    );
  }
}

/// Branch shell.
class BranchShell extends StatefulWidget {
  const BranchShell({super.key});
  @override
  State<BranchShell> createState() => _BranchShellState();
}

class _BranchShellState extends State<BranchShell> {
  String page = 'dashboard';
  String _reportsInitialTab = 'pending';
  bool _reportsExpanded = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const _allItems = [
    _NavItem('home', 'Home', Icons.home_outlined, 'Navigation'),
    _NavItem('dashboard', 'Dashboard', Icons.pie_chart_outline, 'Navigation'),
    _NavItem('customers', 'Customers', Icons.people_outline, 'Main'),
    _NavItem('loans', 'Loans', Icons.description_outlined, 'Main'),
    _NavItem('payments', 'Payments', Icons.payments_outlined, 'Main'),
    _NavItem('reports', 'Reports', Icons.bar_chart, 'Reports'),
    _NavItem('branches', 'Branches', Icons.business_outlined, 'System'),
    _NavItem('staff', 'Staff Management', Icons.manage_accounts_outlined, 'System'),
  ];

  void go(String p) {
    final allowed = Role.pages(appState.currentRole);
    if (!allowed.contains(p)) return;
    setState(() => page = p);
    if (MediaQuery.of(context).size.width < 800) Navigator.pop(context);
  }

  void _goReports(String tabKey) {
    setState(() {
      page = 'reports';
      _reportsInitialTab = tabKey;
      _reportsExpanded = true;
    });
    if (MediaQuery.of(context).size.width < 800) Navigator.pop(context);
  }

  Widget _screen() {
    switch (page) {
      case 'home': return const HomeScreen();
      case 'dashboard': return const DashboardScreen();
      case 'customers': return const CustomersScreen();
      case 'loans': return const LoansScreen();
      case 'payments': return const PaymentsScreen();
      case 'reports': return ReportsScreen(activeReport: _reportsInitialTab);
      case 'branches': return const BranchesScreen();
      case 'staff': return const StaffScreen();
    }
    return const DashboardScreen();
  }

  void _exitBranch() {
    appState.exitBranch();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w >= 1000;
    final branch = appState.activeBranch;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isWide ? null : _drawer(branch),
      backgroundColor: C.bg,
      body: Row(
        children: [
          if (isWide) SizedBox(width: 260, child: _sidebar(branch)),
          Expanded(
            child: Column(
              children: [
                Container(
                  color: const Color(0xFF92400E),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(children: [
                    const Icon(Icons.business, color: C.accent, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You are inside branch: ${branch?.name ?? ''}  ·  ${branch?.location ?? ''}',
                        style: const TextStyle(color: Colors.white,
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _exitBranch,
                      icon: const Icon(Icons.arrow_back, size: 16, color: Colors.white),
                      label: const Text('Back to HQ',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ]),
                ),
                _header(isWide, branch),
                Expanded(child: SingleChildScrollView(child: _screen())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavRow(_NavItem item) {
    final sel = page == item.page && item.page != 'reports';
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: sel ? const Color(0xFF92400E) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (item.page == 'reports') {
              setState(() => _reportsExpanded = !_reportsExpanded);
              if (page != 'reports') go('reports');
            } else {
              go(item.page);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Icon(item.icon, size: 18,
                  color: (sel || (page == 'reports' && item.page == 'reports'))
                      ? C.accent : const Color(0xFFCBD5E1)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(item.label,
                    style: TextStyle(
                      color: (sel || (page == 'reports' && item.page == 'reports'))
                          ? C.accent : const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    )),
              ),
              if (item.page == 'reports')
                Icon(_reportsExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 18, color: const Color(0xFFCBD5E1)),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildReportsSubs() {
    if (!_reportsExpanded) return const SizedBox.shrink();
    if (!Role.canViewReports(appState.currentRole)) return const SizedBox.shrink();
    final canDaily = Role.canViewDaily(appState.currentRole);
    final subs = _reportSubs.where((s) => s.key != 'daily' || canDaily).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 6),
      child: Column(
        children: subs.map((s) {
          final isActiveTab = page == 'reports' && _reportsInitialTab == s.key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Material(
              color: isActiveTab ? const Color(0xFFB45309) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _goReports(s.key),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 9),
                  child: Row(children: [
                    Container(width: 4, height: 4,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            color: isActiveTab ? C.accent : const Color(0xFFCBD5E1))),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(s.label, style: TextStyle(
                        color: isActiveTab ? C.accent : const Color(0xFFCBD5E1),
                        fontSize: 12.5, fontWeight: FontWeight.w500,
                      )),
                    ),
                  ]),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _sidebar(Branch? branch) {
    final allowed = Role.pages(appState.currentRole);
    final visible = _allItems.where((i) => allowed.contains(i.page)).toList();

    final children = <Widget>[];
    String lastSection = '';
    for (final item in visible) {
      if (item.section != lastSection) {
        children.add(Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
          child: Text(item.section.toUpperCase(),
              style: const TextStyle(color: C.accent, fontSize: 11,
                  fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        ));
        lastSection = item.section;
      }
      children.add(_buildNavRow(item));
      if (item.page == 'reports') children.add(_buildReportsSubs());
    }

    return Container(
      color: C.primary,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF92400E))),
            ),
            child: Row(children: [
              const Icon(Icons.payments, color: C.accent, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('QUADRATIC',
                    style: TextStyle(color: Colors.white, fontSize: 18,
                        fontWeight: FontWeight.w700, letterSpacing: 0.5)),
              ),
            ]),
          ),
          if (branch != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: const Color(0xFF92400E),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ACTIVE BRANCH',
                      style: TextStyle(color: C.accent, fontSize: 10,
                          fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                  Text(branch.name,
                      style: const TextStyle(color: Colors.white,
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              children: children,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFF92400E))),
            ),
            child: Row(children: [
              const _UserAvatar(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appState.currentUserName,
                        style: const TextStyle(color: Colors.white,
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    Text(Role.label(appState.currentRole),
                        style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 11)),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _header(bool isWide, Branch? branch) {
    final titles = {
      'home': 'Home', 'dashboard': 'Dashboard', 'customers': 'Customers',
      'loans': 'Loans', 'payments': 'Payments',
      'reports': 'Reports — ${_reportSubs.firstWhere((s) => s.key == _reportsInitialTab, orElse: () => const _ReportSub('pending', 'Pending')).label}',
      'branches': 'Branches',
      'staff': 'Staff Management',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: C.border)),
      ),
      child: Row(
        children: [
          if (!isWide)
            IconButton(
              icon: const Icon(Icons.menu, color: C.textPrimary),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titles[page] ?? '',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,
                        color: C.textPrimary)),
                if (branch != null)
                  Text(branch.name,
                      style: const TextStyle(fontSize: 12, color: C.textMuted)),
              ],
            ),
          ),
          if (isWide)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(todayFormatted(),
                  style: const TextStyle(fontSize: 13, color: C.textMuted)),
            ),
          const SizedBox(width: 12),
          PopupMenuButton<String>(
            tooltip: 'Account Menu',
            child: const _UserAvatar(),
            onSelected: (v) {
              if (v == 'change_password') {
                showDialog(
                  context: context,
                  builder: (_) => const ChangePasswordDialog(),
                );
              } else if (v == 'logout') {
                appState.logout();
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appState.currentUserName,
                        style: const TextStyle(fontWeight: FontWeight.w700, color: C.textPrimary)),
                    Text(Role.label(appState.currentRole),
                        style: const TextStyle(fontSize: 11, color: C.textMuted)),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'change_password',
                child: Row(children: [
                  Icon(Icons.lock_reset, size: 18, color: C.primary),
                  SizedBox(width: 10),
                  Text('Change Password'),
                ]),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(children: [
                  Icon(Icons.logout, size: 18, color: C.danger),
                  SizedBox(width: 10),
                  Text('Sign Out', style: TextStyle(color: C.danger)),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawer(Branch? branch) => Drawer(
    backgroundColor: C.primary,
    child: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF92400E))),
            ),
            child: Row(children: [
              const Icon(Icons.payments, color: C.accent, size: 28),
              const SizedBox(width: 10),
              const Text('QUADRATIC',
                  style: TextStyle(color: Colors.white, fontSize: 18,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: () => Navigator.pop(context),
              ),
            ]),
          ),
          Expanded(child: _sidebar(branch)),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  8. STAFF
// ═══════════════════════════════════════════════════════════════════════════
class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canManage = Role.canRegisterStaff(appState.currentRole);
    return AnimatedBuilder(
      animation: appState,
      builder: (_, __) {
        final list = appState.visibleStaff;
        return PageWrap(children: [
          SectionTitle('🧑‍💼', 'Staff Management'),
          SectionCard(
            title: '${list.length} staff member(s)',
            child: Column(children: [
              if (canManage)
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: () => _addStaffDialog(context),
                    icon: const Icon(Icons.person_add),
                    label: Text(appState.activeBranchId == null
                        ? 'Add Staff'
                        : 'Add Staff to ${appState.activeBranch?.name ?? ''}'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: C.primary, foregroundColor: Colors.white),
                  ),
                ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(columnSpacing: 16, columns: [
                  const DataColumn(label: Text('PHOTO')),
                  const DataColumn(label: Text('ID')),
                  const DataColumn(label: Text('NAME')),
                  const DataColumn(label: Text('NIN')),
                  const DataColumn(label: Text('DISTRICT')),
                  const DataColumn(label: Text('DOB')),
                  const DataColumn(label: Text('EMAIL')),
                  const DataColumn(label: Text('PHONE')),
                  const DataColumn(label: Text('ROLE')),
                  const DataColumn(label: Text('BRANCH')),
                  const DataColumn(label: Text('STATUS')),
                  if (canManage) const DataColumn(label: Text('ACTIONS')),
                ], rows: list.map((s) {
                  final branchName = s.branchId == null
                      ? '—'
                      : appState.branches
                      .firstWhere((b) => b.id == s.branchId,
                      orElse: () => Branch(id: 0, name: '—', location: ''))
                      .name;
                  return DataRow(cells: [
                    DataCell(s.photo != null
                        ? ClipOval(child: Image.memory(s.photo!,
                        width: 32, height: 32, fit: BoxFit.cover))
                        : const Icon(Icons.person, size: 26, color: C.textFaint)),
                    DataCell(Text('${s.id}')),
                    DataCell(Text(s.fullName,
                        style: const TextStyle(fontWeight: FontWeight.w600))),
                    DataCell(Text(s.nin)),
                    DataCell(Text(s.district)),
                    DataCell(Text(s.dob)),
                    DataCell(Text(s.email)),
                    DataCell(Text(s.phone)),
                    DataCell(StatusBadge(Role.label(s.role))),
                    DataCell(Text(branchName,
                        style: const TextStyle(fontSize: 12))),
                    DataCell(StatusBadge(s.status)),
                    if (canManage)
                      DataCell(s.username == 'manager'
                          ? const Text('Protected',
                          style: TextStyle(color: C.textFaint, fontSize: 12))
                          : Row(children: [
                        if (s.status == 'Active')
                          TextButton(
                            onPressed: () {
                              s.status = 'Inactive';
                              appState.refresh();
                            },
                            child: const Text('Deactivate',
                                style: TextStyle(color: C.warning, fontSize: 12)),
                          )
                        else ...[
                          TextButton(
                            onPressed: () {
                              s.status = 'Active';
                              appState.refresh();
                            },
                            child: const Text('Activate',
                                style: TextStyle(color: C.success, fontSize: 12)),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 16, color: C.danger),
                            onPressed: () {
                              appState.staffList.removeWhere((x) =>
                                  x.id == s.id && x.branchId == s.branchId);
                              appState.refresh();
                            },
                          ),
                        ],
                      ])),
                  ]);
                }).toList()),
              ),
            ]),
          ),
        ]);
      },
    );
  }

  void _addStaffDialog(BuildContext context) {
    final name = TextEditingController();
    final nin = TextEditingController();
    final district = TextEditingController();
    final dob = TextEditingController();
    final email = TextEditingController();
    final phone = TextEditingController();
    final username = TextEditingController();
    final password = TextEditingController();
    bool obscurePass = true;
    String role = '';
    int? branchId = appState.activeBranchId;
    Uint8List? photoBytes;
    final picker = ImagePicker();

    Future<void> pickPhoto(StateSetter setS) async {
      try {
        final file = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 70, maxWidth: 800);
        if (file == null) return;
        final bytes = await file.readAsBytes();
        setS(() => photoBytes = bytes);
      } catch (_) {}
    }

    showDialog(context: context, builder: (_) => StatefulBuilder(
      builder: (ctx, setS) => AlertDialog(
        title: Text(appState.activeBranchId == null
            ? 'Register Staff'
            : 'Register Staff → ${appState.activeBranch?.name ?? ''}'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Column(children: [
              const Text('Staff Photo *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Stack(children: [
                InkWell(
                  onTap: () => pickPhoto(setS),
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                    width: 110, height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFAFBFC),
                      border: Border.all(color: C.border, width: 2),
                    ),
                    child: photoBytes == null
                        ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file, size: 30, color: C.textFaint),
                          SizedBox(height: 4),
                          Text('Tap to upload',
                              style: TextStyle(fontSize: 10, color: C.textFaint)),
                        ])
                        : ClipOval(child: Image.memory(photoBytes!,
                        fit: BoxFit.cover, width: 110, height: 110)),
                  ),
                ),
                if (photoBytes != null)
                  Positioned(
                    right: 0, bottom: 0,
                    child: InkWell(
                      onTap: () => setS(() => photoBytes = null),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: C.danger, shape: BoxShape.circle),
                        child: const Icon(Icons.close, color: Colors.white, size: 12),
                      ),
                    ),
                  ),
              ]),
            ]),
            const SizedBox(height: 12),
            TextField(controller: name,
                decoration: const InputDecoration(labelText: 'Full Name *')),
            TextField(controller: nin,
                decoration: const InputDecoration(labelText: 'NIN *')),
            TextField(controller: district,
                decoration: const InputDecoration(labelText: 'District *')),
            TextField(controller: dob,
                decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD) *')),
            TextField(controller: email,
                decoration: const InputDecoration(labelText: 'Email *')),
            TextField(controller: phone,
                decoration: const InputDecoration(labelText: 'Phone *')),
            TextField(controller: username,
                decoration: const InputDecoration(labelText: 'Username *')),
            const SizedBox(height: 8),
            TextField(
              controller: password,
              obscureText: obscurePass,
              decoration: InputDecoration(
                labelText: 'Initial Password *',
                helperText: 'Must contain: 8+ chars, digits, letters & symbols',
                helperMaxLines: 2,
                suffixIcon: IconButton(
                  icon: Icon(obscurePass ? Icons.visibility_off : Icons.visibility, size: 18),
                  onPressed: () => setS(() => obscurePass = !obscurePass),
                ),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: role.isEmpty ? null : role,
              decoration: const InputDecoration(labelText: 'Role *'),
              items: const [
                DropdownMenuItem(value: 'supervisor', child: Text('Supervisor')),
                DropdownMenuItem(value: 'cashier', child: Text('Cashier')),
                DropdownMenuItem(value: 'field_officer', child: Text('Field Officer')),
              ],
              onChanged: (v) => setS(() => role = v ?? ''),
            ),
            const SizedBox(height: 8),
            if (appState.activeBranchId == null)
              DropdownButtonFormField<int>(
                initialValue: branchId,
                decoration: const InputDecoration(labelText: 'Assign Branch *'),
                items: appState.branches
                    .map((b) => DropdownMenuItem(value: b.id, child: Text(b.name)))
                    .toList(),
                onChanged: (v) => setS(() => branchId = v),
              )
            else
              InputDecorator(
                decoration: const InputDecoration(labelText: 'Branch (locked)'),
                child: Text(appState.activeBranch?.name ?? ''),
              ),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: C.primary, foregroundColor: Colors.white),
            onPressed: () {
              if (name.text.isEmpty || nin.text.isEmpty || district.text.isEmpty ||
                  dob.text.isEmpty || email.text.isEmpty || phone.text.isEmpty ||
                  username.text.isEmpty || role.isEmpty || branchId == null ||
                  password.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all required fields')));
                return;
              }
              final passErr = PasswordValidator.validate(password.text);
              if (passErr != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('❌ $passErr')));
                return;
              }
              if (photoBytes == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Staff photo required')));
                return;
              }
              appState.staffList.add(Staff(
                id: appState.nextStaffIdFor(branchId),
                fullName: name.text,
                email: email.text,
                phone: phone.text,
                username: username.text,
                password: password.text.trim(),
                role: role,
                nin: nin.text,
                district: district.text,
                dob: dob.text,
                branchId: branchId,
                photo: photoBytes,
              ));
              appState.refresh();
              Navigator.pop(ctx);
            },
            child: const Text('Register'),
          ),
        ],
      ),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  9. CHANGE PASSWORD DIALOG
// ═══════════════════════════════════════════════════════════════════════════
class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _oldPass = TextEditingController();
  final _newPass = TextEditingController();
  final _confirmPass = TextEditingController();
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String? _errorMessage;

  @override
  void dispose() {
    _oldPass.dispose();
    _newPass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  void _submit() {
    final err = appState.changePassword(
      _oldPass.text,
      _newPass.text,
      _confirmPass.text,
    );
    if (err != null) {
      setState(() => _errorMessage = err);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Password changed successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.lock_reset, color: C.primary),
          SizedBox(width: 8),
          Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logged in as: ${appState.currentUserName} (${Role.label(appState.currentRole)})',
              style: const TextStyle(fontSize: 12, color: C.textMuted),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _oldPass,
              obscureText: _obscureOld,
              decoration: InputDecoration(
                labelText: 'Current Password *',
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(_obscureOld ? Icons.visibility_off : Icons.visibility, size: 18),
                  onPressed: () => setState(() => _obscureOld = !_obscureOld),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _newPass,
              obscureText: _obscureNew,
              decoration: InputDecoration(
                labelText: 'New Password *',
                prefixIcon: const Icon(Icons.key, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(_obscureNew ? Icons.visibility_off : Icons.visibility, size: 18),
                  onPressed: () => setState(() => _obscureNew = !_obscureNew),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _confirmPass,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                labelText: 'Confirm New Password *',
                prefixIcon: const Icon(Icons.check_circle_outline, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, size: 18),
                  onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: const Text(
                'Password must be at least 8 characters and include digits (0-9), letters (a-z), and special symbols (!@#\$%^&*).',
                style: TextStyle(fontSize: 11, color: Color(0xFF92400E)),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                '❌ $_errorMessage',
                style: const TextStyle(color: C.danger, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: C.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Save Password'),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  10. LOGIN SCREEN
// ═══════════════════════════════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameCtrl = TextEditingController(text: 'manager');
  final _passwordCtrl = TextEditingController(text: r'ogwal88@$ton');
  bool _obscurePassword = true;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _doLogin() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final err = appState.login(_usernameCtrl.text, _passwordCtrl.text);

    setState(() {
      _isLoading = false;
      _errorMessage = err;
    });
  }

  void _fillAccount(String username, String pass) {
    setState(() {
      _usernameCtrl.text = username;
      _passwordCtrl.text = pass;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 24 : 36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Brand Icon
                    Center(
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: C.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: C.primary.withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.payments, color: C.accent, size: 34),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'QUADRATIC FS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: C.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Money Lending Management System',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: C.textMuted),
                    ),
                    const SizedBox(height: 28),

                    // Error Box
                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFFCA5A5)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: C.danger, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: C.danger, fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Username
                    TextField(
                      controller: _usernameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Username or Email',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextField(
                      controller: _passwordCtrl,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                            color: C.textMuted,
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      onSubmitted: (_) => _doLogin(),
                    ),
                    const SizedBox(height: 24),

                    // Sign In Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _doLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: C.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 1,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                    ),
                    const SizedBox(height: 24),

                    // Quick Staff Accounts Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quick Logins (Tap to Select):',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: C.textMuted),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              _accountChip('Manager (Sarah)', 'manager', r'ogwal88@$ton', C.primary),
                              _accountChip('Supervisor (John)', 'john', 'John123@#', C.info),
                              _accountChip('Cashier (Grace)', 'grace', 'Grace123@#', C.success),
                              _accountChip('Field Officer (Peter)', 'peter', 'Peter123@#', const Color(0xFFD97706)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        '© 2026 Quadratic Financial Services · All Rights Reserved',
                        style: TextStyle(fontSize: 11, color: C.textFaint),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _accountChip(String label, String username, String pass, Color color) {
    return InkWell(
      onTap: () => _fillAccount(username, pass),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
        ),
      ),
    );
  }
}