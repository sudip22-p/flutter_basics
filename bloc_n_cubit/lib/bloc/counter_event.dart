part of 'counter_bloc.dart';
sealed class CounterEvent {} //sealed here : can't subclass it outside of this library or part..

final class CounterIncremented
    extends
        CounterEvent {} //final locks everything here no further extending ...

final class CounterDecremented extends CounterEvent {}
