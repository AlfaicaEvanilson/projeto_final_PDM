import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/pagina/add_membro.dart';
import 'package:medicine_reminder/pagina/definicoes.dart';
import 'package:medicine_reminder/pagina/detalhes_medicamento/detalhes_medicamento.dart';
import 'package:medicine_reminder/pagina/new_entry/nova_pagina.dart';
import 'package:medicine_reminder/pagina/perfil.dart';
import 'package:sizer/sizer.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dosagem diaria'),
        centerTitle: true,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.point_of_sale),
            onPressed: () {},
          )
        ],
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'LOGO',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_box_rounded),
                title: Text(
                  'Perfil',
                  style: TextStyle(fontSize: 20, color: kOtherColor),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Perfil(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text(
                  'Adicionar membro',
                  style: TextStyle(fontSize: 20, color: kOtherColor),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddMembro(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Definições',
                  style: TextStyle(fontSize: 20, color: kOtherColor),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Definicoes(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            const TopConteiner(),
            SizedBox(
              height: 2.h,
            ),
            const Flexible(
              child: BottomContainer(),
            ),
          ],
        ),
      ),
      floatingActionButton: InkResponse(
        onTap: () {
          // go to new entry page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const NovaPagina()),
            ),
          );
        },
        child: SizedBox(
          child: SizedBox(
            width: 18.w,
            height: 9.h,
            child: Card(
              color: kPrimaryColor,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(3.h),
              ),
              child: Icon(
                Icons.add_outlined,
                color: kScaffoldColor,
                size: 50.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopConteiner extends StatelessWidget {
  const TopConteiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
          child: Text(
            'Viva saudavel.',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Container(
          child: DatePicker(
            DateTime.now(),
            height: 7.h,
            width: 8.h,
            initialSelectedDate: DateTime.now(),
            selectionColor: kPrimaryColor,
            selectedTextColor: kScaffoldColor,
            dateTextStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 1.h),
          child: Text(
            '0',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    /*return Center(
      child: Text(
        'Sem medicamento',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );*/
    return GridView.builder(
      padding: EdgeInsets.only(top: 1.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return MedicineCard();
      },
    );
  }
}

class MedicineCard extends StatefulWidget {
  const MedicineCard({super.key});

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesMedicamento(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 2.w,
          right: 2.w,
          top: 1.h,
          bottom: 1.h,
        ),
        margin: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              'asset/icons/bottle.svg',
              height: 7.h,
              colorFilter:
                  const ColorFilter.mode(kPrimaryColor, BlendMode.color),
            ),
            const Spacer(),
            Text(
              'Calpol',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: kPrimaryColor),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Text(
              'De 8 em 8 horas',
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
