# changing_widgets_in_response_to_input_complex

import the material library

define the main function
  runApp with the MaterialApp widget containing a Scaffold widget with a Center widget containing the Counter widget

define the Counter widget as a stateful widget
  define a private integer variable _counter and initialize it with 0
  define a private function _increment to increment the _counter variable
  override the build method to create a Column widget containing the CounterDisplay and CounterIncrement widgets

define the CounterDisplay widget as a stateless widget
  define a required integer prop count
  override the build method to create a Text widget with the count prop

define the CounterIncrement widget as a stateless widget
  define a required function prop onPressed
  override the build method to create an ElevatedButton widget with the onPressed prop
