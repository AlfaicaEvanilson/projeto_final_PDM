import 'package:medicine_reminder/models/errors.dart';
import 'package:medicine_reminder/models/tipo_medicamento.dart';
import 'package:rxdart/rxdart.dart';

class NewEntryBloc {
  BehaviorSubject<TipoMedicamento>? _selectedMedicineType$;
  ValueStream<TipoMedicamento>? get selectedMedicineType =>
      _selectedMedicineType$!.stream;

  BehaviorSubject<int>? _selectedInterval$;
  BehaviorSubject<int>? get selectIntevals => _selectedInterval$;

  BehaviorSubject<String>? _selectedTimeOfDay$;
  BehaviorSubject<String>? get selectedTimeOfDay$ => _selectedTimeOfDay$;

  //error state
  BehaviorSubject<EntryError>? _errorState$;
  BehaviorSubject<EntryError>? get errorState$ => _errorState$;

  NewEntryBloc() {
    _selectedMedicineType$ =
        BehaviorSubject<TipoMedicamento>.seeded(TipoMedicamento.none);

    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded('none');
    _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
  }
  void dispose() {
    _selectedMedicineType$!.close();
    _selectedTimeOfDay$!.close();
    _selectedInterval$!.close();
  }

  void submitError(EntryError error) {
    _errorState$!.add(error);
  }

  void updateInterval(int interval) {
    _selectedInterval$!.add(interval);
  }

  void updateTime(String time) {
    _selectedTimeOfDay$!.add(time);
  }

  void updateSelectedMedicine(TipoMedicamento type) {
    TipoMedicamento _tempType = _selectedMedicineType$!.value;
    if (type == _tempType) {
      _selectedMedicineType$!.add(TipoMedicamento.none);
    } else {
      _selectedMedicineType$!.add(type);
    }
  }
}
