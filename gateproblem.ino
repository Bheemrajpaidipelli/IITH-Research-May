const int U_PIN = 2;
const int V_PIN = 3;
const int W_PIN = 4;
const int OUT_PIN = 13;

void setup()
{
    pinMode(U_PIN, INPUT_PULLUP);
    pinMode(V_PIN, INPUT_PULLUP);
    pinMode(W_PIN, INPUT_PULLUP);

    pinMode(OUT_PIN, OUTPUT);

    Serial.begin(9600);
}

void loop()
{
    bool U = !digitalRead(U_PIN);
    bool V = !digitalRead(V_PIN);
    bool W = !digitalRead(W_PIN);

    // I = U(V + W')
    bool I = U && (V || !W);

    digitalWrite(OUT_PIN, I);

    Serial.print("U=");
    Serial.print(U);

    Serial.print(" V=");
    Serial.print(V);

    Serial.print(" W=");
    Serial.print(W);

    Serial.print(" I=");
    Serial.println(I);

    delay(200);
}