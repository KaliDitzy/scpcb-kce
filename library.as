using namespace B3D;
using namespace CB;

class Vector3 {
    float X;
    float Y;
    float Z;

    Vector3(float x, float y, float z) {
        this.X = x;
        this.Y = y;
        this.Z = z;
    }

    Vector3 From(string string) {
        int s1 = string.Find(" ");
        int s2 = string.Find(" ", s1 + 1);

        return Vector3(string.Substring(0, s1).ParseFloat(), string.Substring(s1 + 1, s2 - s1 - 1).ParseFloat(), string.Substring(s2 + 1).ParseFloat());
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