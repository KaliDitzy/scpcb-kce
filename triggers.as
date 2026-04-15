using namespace B3D;
using namespace CB;

class Trigger {
    private string name;
    private string roomName;
    private float minX, minY, minZ, maxX, maxY, maxZ;

    string Name() { return this.name; }
    string RoomName() { return this.roomName; }
    float MinX() { return this.minX; }
    float MinY() { return this.minY; }
    float MinZ() { return this.minZ; }
    float MaxX() { return this.maxX; }
    float MaxY() { return this.maxY; }
    float MaxZ() { return this.maxZ; }
    bool Inside(Pivot@ pivot) {
        if (pivot.GetX(true) >= this.MinX() && pivot.GetX(true) <= this.MaxX()) {
            if (pivot.GetY(true) >= this.MinY() && pivot.GetY(true) <= this.MaxY()) {
                if (pivot.GetZ(true) >= this.MinZ() && pivot.GetZ(true) <= this.MaxZ()) {
                    return true;
                }
            }
        }
        
        return false;
    }

    Trigger() {
        this.name = "";
        this.roomName = "";
        this.minX = 0;
        this.minY = 0;
        this.minZ = 0;
        this.maxX = 0;
        this.maxY = 0;
        this.maxZ = 0;
    }
    Trigger(string name, string roomName, float minX, float minY, float minZ, float maxX, float maxY, float maxZ) {
        this.name = name;
        this.roomName = roomName;
        this.minX = minX;
        this.minY = minY;
        this.minZ = minZ;
        this.maxX = maxX;
        this.maxY = maxY;
        this.maxZ = maxZ;
    }
}

array<Trigger> triggers;

void RegisterTrigger(string name, string roomName, float minX, float minY, float minZ, float maxX, float maxY, float maxZ) {
    triggers.InsertLast(Trigger(name, roomName, minX, minY, minZ, maxX, maxY, maxZ));
}