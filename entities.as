using namespace B3D;
using namespace CB;

#include "library.as"
#include "subrooms.as"

class TempJunk {
    RoomTemplate@ rt;

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

    TempJunk() {
        this.x = 0; this.y = 0; this.z = 0;
        this.file1 = ""; this.file2 = ""; this.file3 = "";
        this.minPos = Vector3(); this.maxPos = Vector3();
        this.maxRot = Vector3();
        this.minScale = 1; this.maxScale = 1;
        this.minObj = 1; this.maxObj = 1;
    }
    TempJunk(RoomTemplate@ rt, float x, float y, float z, string file1, string file2, string file3, Vector3 minPos, Vector3 maxPos, Vector3 maxRot, float minScale, float maxScale, int minObj, int maxObj) {
        @this.rt = rt;
        this.x = x; this.y = y; this.z = z;
        this.file1 = file1; this.file2 = file2; this.file3 = file3;
        this.minPos = minPos; this.maxPos = maxPos;
        this.maxRot = maxRot;
        this.minScale = minScale; this.maxScale = maxScale;
        this.minObj = minObj; this.maxObj = maxObj;
    }

    string RandomFile() {
        int select = Rand(0,2);
        switch(select) {
            case 0:
                return file1;
                break;
            case 1:
                if (file2 != "") { return file2; }
                else { return RandomFile(); }
                break;
            case 2:
                if (file3 != "") { return file3; }
                else { return RandomFile(); }
                break;
            default:
                return file1;
        }
    }

    void Spawn(Room@ r) {
        for (int i = 0; i < Rand(minObj, maxObj); i++) {
            Entity@ o = LoadMesh(RandomFile(), null);
            o.Position(r.X + (Rnd(minPos.X, maxPos.X) / 256.f), r.Y + (Rnd(minPos.Y, maxPos.Y) / 256.f), r.Z + (Rnd(minPos.Z, maxPos.Z) / 256.f), true);
            o.Rotate(Rnd(0, maxRot.X), Rnd(0, maxRot.Y), Rnd(0, maxRot.Z), true);
            o.Scale(Rnd(minScale, maxScale), Rnd(minScale, maxScale), Rnd(minScale, maxScale), true);
            o.SetParent(r.Object, true);
        }
    }
};

array<TempJunk> tempJunk;

void RegisterTempJunk(TempJunk tj) {
    tempJunk.InsertLast(tj);
}

class TempSubroom {
    RoomTemplate@ rt;

    float x;
    float y;
    float z;
    int angle;

    SubroomTemplate@ subroomTemplate;

    TempSubroom() {
        this.subroomTemplate = @PickSubroomTemplate(CollectSubroomTemplates(512, 512, 1));
    }
    TempSubroom(RoomTemplate@ rt, SubroomTemplate@ subroomTemplate, float x, float y, float z, int angle) {
        @this.rt = rt;
        this.subroomTemplate = @subroomTemplate;
        this.x = x; this.y = y; this.z = z; this.angle = angle;
    }

    void Spawn(Room@ r) {
        subroomTemplate.CreateSubroom(r.X + (x / 256.f), r.Y + (y / 256.f), r.Z + (z / 256.f), angle);
    }
}

array<TempSubroom> tempSubrooms;

void RegisterTempSubroom(TempSubroom ts) {
    tempSubrooms.InsertLast(ts);
}