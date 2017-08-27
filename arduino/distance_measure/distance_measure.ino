#include <Albert.h>

byte data[1024];

int numSamples=0;
long t, t0;

//float results[20];
int num_tests = 0;

void setup()
{
  Serial.begin(115200);
  pinMode(2, OUTPUT);
  ADCSRA = 0;             // clear ADCSRA register
  ADCSRB = 0;             // clear ADCSRB register
  ADMUX |= (0 & 0x07);    // set A0 analog input pin
  ADMUX |= (1 << REFS0);  // set reference voltage
  ADMUX |= (1 << ADLAR);  // left align ADC value to 8 bits from ADCH register

  // sampling rate is [ADC clock] / [prescaler] / [conversion clock cycles]
  // for Arduino Uno ADC clock is 16 MHz and a conversion takes 13 clock cycles
  //ADCSRA |= (1 << ADPS2) | (1 << ADPS0);    // 32 prescaler for 38.5 KHz
  //ADCSRA |= (1 << ADPS2);                     // 16 prescaler for 76.9 KHz
  ADCSRA |= (1 << ADPS1) | (1 << ADPS0);    // 8 prescaler for 153.8 KHz

  ADCSRA |= (1 << ADATE); // enable auto trigger
  ADCSRA |= (1 << ADIE);  // enable interrupts when measurement complete
  ADCSRA |= (1 << ADEN);  // enable ADC
  ADCSRA |= (1 << ADSC);  // start ADC measurements

  delay(1000);
  Serial.print("aaaaaaaa");
  numSamples = 0;
}

ISR(ADC_vect)
{
  if (numSamples < 1000)
  {
    byte x = ADCH;  // read 8 bit value from ADC
    data[numSamples] = x;
    numSamples++;
  }
}

float median(int n, float x[]) {
    float temp;
    int i, j;
    // the following two loops sort the array x in ascending order
    for(i=0; i<n-1; i++) {
        for(j=i+1; j<n; j++) {
            if(x[j] < x[i]) {
                // swap elements
                temp = x[i];
                x[i] = x[j];
                x[j] = temp;
            }
        }
    }

    if(n%2==0) {
        // if there is an even number of elements, return mean of the two elements in the middle
        return((x[n/2] + x[n/2 - 1]) / 2.0);
    } else {
        // else return the element in the middle
        return x[n/2];
    }
}

float y[1000] = {0.0};
float numz[7] = {0.0005, 0, -0.0014, 0, 0.0014, 0, -0.0005};
float denz[7] = {1.0000, -5.4526, 12.5947, -15.7654, 11.2776, -4.3721, 0.7182};
  
void loop()
{
  
  //if (numSamples>=1000)
  //{
      t = micros()-t0;  // calculate elapsed time

      for (int i = 0; i < 1024; ++i)
      {

        int adcFast4 = analogReadFast(ADCpin); // default value 4 = 20us
      }
      

        //Serial.print("Sampling frequency: ");
        //Serial.print((float)1000000/t);
        //Serial.println(" KHz");
        digitalWrite(2, LOW);

        /*
        float total_sum = 0;
        float max_val = 0;

        float avg = 0;
        
        for (int i = 0; i < 1000; ++i)
        {
          y[i] = 0;
          avg += data[i];
          if (max_val < data[i]) {
            max_val = data[i];
          }
        }
        avg/=1000;
        
              
        for (int i = 6; i < 1000; i++)
        {
            for (int j = 0; j < 7; ++j)
            {
                y[i] = y[i] + ((data[i - j] - avg)/max_val)*numz[j] - y[i - j]*denz[j];
                
            }
        }

        // Set y 0-5 to be = norm_data 0? 
        max_val = 0;
        for(int i = 0; i < 1000; ++i)
        {
            y[i] = abs(y[i]);

          if (max_val < y[i]) {
            max_val = y[i];
          }
        }


        for (int i = 0; i < 1000; ++i)
        {
          y[i] /= max_val;
        }

        Serial.println();
        
        
        
        for (int i = 0; i < 1000; ++i)
        {
            Serial.print(data[i]);
            Serial.print(", ");
          
          //if (y[i] > 0.2)
          //{
            //Serial.print("Distance is: ");
            //float val = 20; //(i*340.29/((float)1000000000/t));
            //byte * b = (byte *)(&val);
            //Serial.write(b, 4);
            //results[num_tests] = i*340.29/((float)1000000000/t);
            //num_tests ++;
            //break;
            
          //}
        }
        Serial.print("\n\n");
 
        
        //byte * b = (byte *)(data);
        //Serial.write(b, 999);
        
        

        float avg_so_far = 0;

        
        for(int i=0; i<999; i++) {
          avg_so_far = (i*avg_so_far + data[i])/(i + 1.0);
    
          if (abs(data[i] - avg_so_far) > 1.1)
          {
            //Serial.println(i);
            
            Serial.print("Distance is: ");
            Serial.println(i*340.29/((float)1000000000/t) - 0.11);
            results[num_tests] = i*340.29/((float)1000000000/t);
            num_tests ++;
            break;
          }
          //Serial.print(data[i]);
          //Serial.print(", ");
        }
        
  //    }


      delay(2000);
      digitalWrite(2, HIGH);
      // restart
      t0 = micros();
      numSamples=0;
      */
  //}
}
