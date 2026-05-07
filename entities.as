using namespace B3D;
using namespace CB;

#include "library.as"

class TempJunk {
    float x;
    float y;
    float z;

    string file1;
    string file2;
    string file3;

    Vector3 minPos;
    Vector3 maxPos;

    Vector3 maxRot;
    
    float minScale;
    float maxScale;
    
    int minObj;
    int maxObj;

    TempJunk(float x, float y, float z, string file1, string file2, string file3, Vector3 minPos, Vector3 maxPos, Vector3 maxRot, float minScale, float maxScale, int minObj, int maxObj) {
        this.x = x; this.y = y; this.z = z;
        this.file1 = file1; this.file2 = file2; this.file3 = file3;
        this.minPos = minPos; this.maxPos = maxPos;
        this.maxRot = maxRot;
        this.minScale = minScale; this.maxScale = maxScale;
        this.minObj = minObj; this.maxObj = maxObj;
    }

    void Spawn(Room@ r) {
        
    }
};

array<TempJunk> tempJunk;

void RegisterTempJunk(TempJunk tj) {
    tempJunk.InsertLast(tj);
}