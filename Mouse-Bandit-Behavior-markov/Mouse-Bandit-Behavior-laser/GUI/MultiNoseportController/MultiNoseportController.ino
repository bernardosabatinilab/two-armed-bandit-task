
#include "NosePort.h"

// Set this to 1 for debug mode, otherwise set to 0
#define DEBUG_MODE 0

#if DEBUG_MODE
  int debugPin = 12;  // Pin 12 will be in use in DEBUG MODE
#endif

void DEBUG(String message) {
#if DEBUG_MODE
  Serial.println(message.c_str());
#endif
}

bool alternateLoopFlag = false; // DEBUG

void setup() {
  // set up USB communication at 115200 baud
  Serial.begin(115200);
  // tell PC that we're running by sending 'S' message
  Serial.println("S");

  // DEBUG
#if DEBUG_MODE
  pinMode(debugPin, OUTPUT);
#endif
}

void loop() {
  // read from USB, if available
  static String usbMessage = ""; // initialize usbMessage to empty string,
                                 // happens once at start of program
  if (Serial.available() > 0) {
    // read next char if available
    char inByte = Serial.read();
    if (inByte == '\n') {
      // the new-line character ('\n') indicates a complete message
      // so interprete the message and then clear buffer
      NosePort::interpretCommand(usbMessage);
      usbMessage = ""; // clear message buffer
    } else {
      // append character to message buffer
      usbMessage = usbMessage + inByte;
    }
  }

  // loop through all nose ports and tell them to 'update'
  //    (i.e., check for nose in/out; open/close the solenoid, if needed)
  for (int i=0; i<NosePort::nosePortListSize; i++) {
    NosePort* p = NosePort::nosePortList[i];
    p->update();
  }

  // DEBUG
#if DEBUG_MODE
  if (alternateLoopFlag) {
    digitalWrite(debugPin, HIGH);
  } else {
    digitalWrite(debugPin, LOW);
  }
  alternateLoopFlag = !alternateLoopFlag;
#endif
}
