import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

Context context;
SensorManager manager;
Sensor sensor;
AccelerometerListener listener;
float ax, ay, az;

public void onResume() {
  super.onResume();
  if (manager != null) {
    manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
  }
}


public void onPause() {
  super.onPause();
  if (manager != null) {
    manager.unregisterListener(listener);
  }
}


void setup() {
  fullScreen();
  
  context = getActivity();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  listener = new AccelerometerListener();
  manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
  
  textFont(createFont("SansSerif", 30 * displayDensity));
}

void draw() {
  background(252, 136, 3);
  fill(212,32,23);
  rect(200,0,200, displayWidth-displayHeight/ay);
  fill(212,32,212);
  rect(400,0,200, displayWidth-displayHeight/ax);
  fill(212,121,212);
  rect(600,0,200, displayWidth-displayHeight/az);
  fill(0);
  text("X: " + ax + "\nY: " + ay + "\nZ: " + az, 0, 0, width, height);
}

class AccelerometerListener implements SensorEventListener {
  public void onSensorChanged(SensorEvent event) {
    ax = event.values[0];
    ay = event.values[1];
    az = event.values[2];    
  }
  public void onAccuracyChanged(Sensor sensor, int accuracy) {
  }
}
