import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_reminder/common/convert_time.dart';

import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/models/tipo_medicamento.dart';
import 'package:medicine_reminder/pagina/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NovaPagina extends StatefulWidget {
  const NovaPagina({super.key});

  @override
  State<NovaPagina> createState() => _NovaPaginaState();
}

class _NovaPaginaState extends State<NovaPagina> {
  late TextEditingController nameController;
  late TextEditingController dosageController;
  late NewEntryBloc _newEntryBloc;

  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _newEntryBloc = NewEntryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Adicione'),
      ),
      body: Provider<NewEntryBloc>.value(
        value: _newEntryBloc,
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PanelTitle(
                title: 'Nome do medicamento',
                isRequired: true,
              ),
              TextFormField(
                maxLength: 12,
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: kOtherColor,
                    ),
              ),
              const PanelTitle(
                title: 'Dosagem em miligrama',
                isRequired: false,
              ),
              TextFormField(
                maxLength: 12,
                controller: dosageController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: kOtherColor,
                    ),
              ),
              const PanelTitle(title: 'Tipo de medicamento', isRequired: false),
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: StreamBuilder<TipoMedicamento>(
                  stream: _newEntryBloc.selectedMedicineType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ColunaTipoMedicamento(
                          medicineType: TipoMedicamento.bottle,
                          name: 'Garrafa',
                          iconValue: 'assets/icons/bottle.svg',
                          isSelected: snapshot.data == TipoMedicamento.bottle
                              ? true
                              : false,
                        ),
                        ColunaTipoMedicamento(
                          medicineType: TipoMedicamento.pill,
                          name: 'Pilulas',
                          iconValue: 'assets/icons/pill.svg',
                          isSelected: snapshot.data == TipoMedicamento.pill
                              ? true
                              : false,
                        ),
                        ColunaTipoMedicamento(
                          medicineType: TipoMedicamento.syringe,
                          name: 'Siringa',
                          iconValue: 'assets/icons/syringe.svg',
                          isSelected: snapshot.data == TipoMedicamento.syringe
                              ? true
                              : false,
                        ),
                        ColunaTipoMedicamento(
                          medicineType: TipoMedicamento.table,
                          name: 'Tabela',
                          iconValue: 'assets/icons/table.svg',
                          isSelected: snapshot.data == TipoMedicamento.table
                              ? true
                              : false,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const PanelTitle(title: 'Selecionar Intervalo', isRequired: true),
              const IntervaloSelecionado(),
              const PanelTitle(title: 'Tempo de Inicio', isRequired: true),
              const TempoSelecionado(),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                ),
                child: SizedBox(
                  width: 80.w,
                  height: 8.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: const StadiumBorder(),
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: kScaffoldColor),
                      ),
                    ),
                    onPressed: () {
                      //adicionar medicamento
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TempoSelecionado extends StatefulWidget {
  const TempoSelecionado({super.key});

  @override
  State<TempoSelecionado> createState() => _TempoSelecionadoState();
}

class _TempoSelecionadoState extends State<TempoSelecionado> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 60);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            _selectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? 'Select Time'
                  : "${convertTime(
                      _time.hour.toString(),
                    )}:${convertTime(
                      _time.minute.toString(),
                    )}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: kScaffoldColor),
            ),
          ),
        ),
      ),
    );
  }
}

class IntervaloSelecionado extends StatefulWidget {
  const IntervaloSelecionado({super.key});

  @override
  State<IntervaloSelecionado> createState() => _IntervaloSelecionadoState();
}

class _IntervaloSelecionadoState extends State<IntervaloSelecionado> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lembrar a cada',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          DropdownButton(
            iconEnabledColor: kOtherColor,
            dropdownColor: kScaffoldColor,
            itemHeight: 8.h,
            hint: _selected == 0
                ? Text(
                    'Selecionar um intervalo',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: kPrimaryColor),
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(() {
                _selected = newVal!;
              });
            },
          ),
          Text(
            _selected == 1 ? "hour" : "hours",
          )
        ],
      ),
    );
  }
}

class ColunaTipoMedicamento extends StatelessWidget {
  const ColunaTipoMedicamento(
      {super.key,
      required this.medicineType,
      required this.name,
      required this.iconValue,
      required this.isSelected});
  final TipoMedicamento medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        //select medicine type
        //criar novo bloco para selecionar e adicionar as entradas
        newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.h),
              color: isSelected ? kOtherColor : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                  bottom: 1.h,
                ),
                child: SvgPicture.asset(
                  iconValue,
                  height: 7.h,
                  colorFilter: isSelected
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : const ColorFilter.mode(kOtherColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 20.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isSelected ? kOtherColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: isSelected ? Colors.white : kOtherColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({super.key, required this.title, required this.isRequired});
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            TextSpan(
              text: isRequired ? " *" : "",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
