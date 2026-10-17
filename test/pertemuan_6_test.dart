import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_mp2/pertemuan/pertemuan_6/tugas.dart';
import 'package:praktikum_mp2/theme/app_theme.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const TugasPertemuan6(),
    );
  }

  testWidgets('TugasPertemuan6 renders Form Pendaftaran Mahasiswa correctly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 3200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Tugas 6: Form Pendaftaran'), findsOneWidget);
    expect(find.text('Formulir Registrasi Mahasiswa Baru'), findsOneWidget);
    expect(find.text('Nama Lengkap Mahasiswa *'), findsOneWidget);
    expect(find.text('Nomor Induk Mahasiswa (NIM) *'), findsOneWidget);
    expect(find.text('Email Kampus / Aktif *'), findsOneWidget);
    expect(find.text('Nomor WhatsApp / HP *'), findsOneWidget);
  });

  testWidgets('TugasPertemuan6 can populate demo data and submit form', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 3200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Tap Isi Data Demo
    final demoBtn = find.text('Isi Data Demo');
    expect(demoBtn, findsOneWidget);
    await tester.tap(demoBtn);
    await tester.pumpAndSettle();

    expect(find.text('Dimas Alfa Pratama'), findsOneWidget);
    expect(find.text('221011400892'), findsOneWidget);

    // Tap Simpan
    final submitBtn = find.text('Simpan Pendaftaran Mahasiswa');
    expect(submitBtn, findsOneWidget);
    await tester.tap(submitBtn);
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    // Verify modal appeared with success state
    expect(find.text('Pendaftaran Berhasil!'), findsOneWidget);
    expect(find.text('KARTU BUKTI PENDAFTARAN'), findsOneWidget);
  });
}
