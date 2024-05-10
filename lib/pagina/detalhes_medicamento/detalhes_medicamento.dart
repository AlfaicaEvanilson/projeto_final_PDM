import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:sizer/sizer.dart';

class DetalhesMedicamento extends StatefulWidget {
  const DetalhesMedicamento({super.key});

  @override
  State<DetalhesMedicamento> createState() => _DetalhesMedicamentoState();
}

class _DetalhesMedicamentoState extends State<DetalhesMedicamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            const MainSection(),
            ExtendedSection(),
            SizedBox(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {},
                child: Text(
                  'Delete',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/bottle.svg',
          height: 7.h,
          colorFilter: ColorFilter.mode(kOtherColor, BlendMode.color),
        ),
        SizedBox(
          width: 2.w,
        ),
        const Column(
          children: [
            MainInfoTab(
              fieldTitle: 'Medicine Name',
              fieldInfo: 'Catapol',
            ),
            MainInfoTab(
              fieldTitle: 'Dosage',
              fieldInfo: '500 mg',
            ),
          ],
        )
      ],
    );
  }
}

class MainInfoTab extends StatelessWidget {
  const MainInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 10.h,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Text(
              fieldInfo,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class ExtendedSection extends StatelessWidget {
  const ExtendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        ExtendedInfoTab(
          fieldTitle: 'Medicine',
          fieldInfo: 'Pill',
        ),
        ExtendedInfoTab(
          fieldTitle: 'Dosage Interval',
          fieldInfo: 'Every',
        ),
        ExtendedInfoTab(
          fieldTitle: 'Start Time',
          fieldInfo: '0',
        ),
      ],
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  const ExtendedInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              fieldTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: kTextColor),
            ),
          ),
          Text(
            fieldInfo,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: kSecondaryColor),
          )
        ],
      ),
    );
  }
}
