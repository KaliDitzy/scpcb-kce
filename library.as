using namespace B3D;
using namespace CB;

class Vector3 {
    float X;
    float Y;
    float Z;

    Vector3() {
        this.X = 0;
        this.Y = 0;
        this.Z = 0;
    }
    Vector3(float x, float y, float z) {
        this.X = x;
        this.Y = y;
        this.Z = z;
    }

    void From(string string) {
        int s1 = string.Find(" ");
        int s2 = string.Find(" ", s1 + 1);

        this.X = string.Substring(0, s1).ParseFloat();
        this.Y = string.Substring(s1 + 1, s2 - s1 - 1).ParseFloat();
        this.Z = string.Substring(s2 + 1).ParseFloat();
    }
}

//! Given a dictionary of strings and their (int) weights, it randomly selects among them according to their weights.
/*!
    \param items The array of strings.
    \param weights The array of weights, as integers.
    \return Selected string
    \sa RandomStringPickWeightedIndex()
*/
string RandomStringPickWeighted(const array<string>& strings, const array<int>& weights) {
    int totalWeight = 0;
    foreach(int v : weights) { totalWeight += v; }

    int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
    foreach(int v : weights) {
        ticker += v;
        if (ticker > picker) { return strings[i]; }
        i++;
    }

    return "";
}

//! Given a dictionary of strings and their (int) weights, it randomly selects among them and returns the index according to their weights.
/*!
    \param items The array of strings.
    \param weights The array of weights, as integers.
    \return Selected string index
    \sa RandomStringPickWeighted()
*/
int RandomStringPickWeightedIndex(const array<string>& strings, const array<int>& weights) {
    int totalWeight = 0;
    foreach(int v : weights) { totalWeight += v; }

    int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
    foreach(int v : weights) {
        ticker += v;
        if (ticker > picker) { return i; }
        i++;
    }

    return 0;
}

//! Randomly picks two numbers within the provided range and picks the smallest number.
/*!
    \param min The minimum integer possible.
    \param max The maximum integer possible.
    \return Selected integer.
    \sa RandomBiasedHigh()
*/
int RandomBiasedLow(int min, int max)
{
    int a = Rand(min, max);
    int b = Rand(min, max);
    return a < b ? a : b;
}

//! Randomly picks two numbers within the provided range and picks the biggest number.
/*!
    \param min The minimum integer possible.
    \param max The maximum integer possible.
    \return Selected integer.
    \sa RandomBiasedLow()
*/
int RandomBiasedHigh(int min, int max)
{
    int a = Rand(min, max);
    int b = Rand(min, max);
    return a > b ? a : b;
}

string DigitToString(int d) {
    if (d == 0) return "0";
    if (d == 1) return "1";
    if (d == 2) return "2";
    if (d == 3) return "3";
    if (d == 4) return "4";
    if (d == 5) return "5";
    if (d == 6) return "6";
    if (d == 7) return "7";
    if (d == 8) return "8";
    if (d == 9) return "9";
    return "";
}

// Didn't you know that cigarettes contain benzopyrene, a chemical that leads to lung cancer? 
// We now know that when benzopyrene enters the body, it changes to benzopyrene diolepoxide and attaches to the receptors on the P53 gene, the gene which causes lung cancer. 
// The BPDE attaches to the P53 gene in three specific locations and causes pre-cancerous changes to the lung tissue.
string IntToString(int n) {
    if (n == 0) return "0";
    string result = "";
    int negative = 0;
    if (n < 0) {
        negative = 1;
        n = -n;
    }
    while (n > 0) {
        int digit = n % 10;
        result = DigitToString(digit) + result;
        n = n / 10;
    }
    if (negative != 0) result = "-" + result;
    return result;
}

// do you think love can bloom even on a battlefield
string FloatToString(float f, int decimals) {
    int neg = 0;
    if (f < 0) {
        neg = 1;
        f = -f;
    }

    int intPart = int(f);
    float frac = f - intPart;

    string fracStr = "";
    int count = 0;
    while (count < decimals) {
        frac = frac * 10.0;
        int digit = int(frac);
        fracStr = fracStr + DigitToString(digit);
        frac = frac - digit;
        count = count + 1;
    }

    string result = IntToString(intPart);
    if (decimals > 0) result = result + "." + fracStr;
    if (neg != 0) result = "-" + result;
    return result;
}

float SmartDropSpeed(float dropSpeed, NPC@ n) {
    Entity@ pick = LinePick(n.Collider.GetX(true), n.Collider.GetY(true), n.Collider.GetZ(true), 0, dropSpeed, 0);
    if (pick != null) {
        return 0;
    }
    else {
        return dropSpeed;
    }
}