using namespace B3D;
using namespace CB;

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

int RandomBiasedLow(int min, int max)
{
    int a = Rand(min, max);
    int b = Rand(min, max);
    return a < b ? a : b;
}

int RandomBiasedHigh(int min, int max)
{
    int a = Rand(min, max);
    int b = Rand(min, max);
    return a > b ? a : b;
}