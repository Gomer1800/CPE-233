const int pwm0 = 2 ;    //Mapping digital pins 2 to 9 as pwm variables 0 (lsb) to 7 (msb)
const int pwm1 = 3;
const int pwm2 = 4;
const int pwm3 = 5; 
const int pwm4 = 6; 
const int pwm5 = 7; 
const int pwm6 = 8; 
const int pwm7 = 9; 
 
const int adc = 0 ;   //naming pin 0 of analog input side as ‘adc’
void setup()
{
     pinMode(pwm0, OUTPUT);
     pinMode(pwm1, OUTPUT);
     pinMode(pwm2, OUTPUT);
     pinMode(pwm3, OUTPUT);
     pinMode(pwm4, OUTPUT);
     pinMode(pwm5, OUTPUT);
     pinMode(pwm6, OUTPUT);
     pinMode(pwm7, OUTPUT);
     
     Serial.begin(9600);
}
void loop()
{
     int adc  = analogRead(0) ;    //reading analog voltage and storing it in an integer
     adc = map(adc, 0, 1023, 0, 255);
     int bit0 = bitRead(adc, 0);
     int bit1 = bitRead(adc, 1);
     int bit2 = bitRead(adc, 2);
     int bit3 = bitRead(adc, 3);
     int bit4 = bitRead(adc, 4);
     int bit5 = bitRead(adc, 5);
     int bit6 = bitRead(adc, 6);
     int bit7 = bitRead(adc, 7);
     
/*
----------map funtion------------
the above funtion scales the output of adc, 
which is 10 bit and gives values btw 0 to 1023, 
in values btw 0 to 255 form analogWrite funtion 
which only receives  values btw this range
*/
    //digital value sent to pin called pwm
     digitalWrite(pwm0, bit0);
     digitalWrite(pwm1, bit1);
     digitalWrite(pwm2, bit2);
     digitalWrite(pwm3, bit3);
     digitalWrite(pwm4, bit4);
     digitalWrite(pwm5, bit5);
     digitalWrite(pwm6, bit6);
     digitalWrite(pwm7, bit7);

     Serial.print("Digital: ");
     Serial.println(adc);
      
     Serial.print("0: ");
     Serial.println(bit0);
     
     Serial.print("1: ");
     Serial.println(bit1);

     Serial.print("2: ");
     Serial.println(bit2);
     
     Serial.print("3: ");
     Serial.println(bit3);
     
     Serial.print("4: ");
     Serial.println(bit4);

     Serial.print("5: ");
     Serial.println(bit5);

     Serial.print("6: ");
     Serial.println(bit6);
     
     Serial.print("7: ");
     Serial.println(bit7);
     delay(500);  //half a second delay
   
}
