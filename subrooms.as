using namespace B3D;
using namespace CB;

class SubroomTemplate {
    int width, height, zone;
    string name;

    SubroomTemplate() {
        this.width = 512;
        this.height = 512;
        this.zone = 1;
        this.name = "";
    }
    SubroomTemplate(int width, int height, int zone, string name) {
        this.width = width; this.height = height; this.zone = zone;
        this.name = name;
    }

    Room@ CreateSubroom(float x, float y, float z, int angle) {
        Console::CreateMessage("Creating Subroom from SubroomTemplate");
        Room@ newRoom = Room(this.zone, -1, x, y, z, angle, this.name);

        Console::CreateMessage("Loading RMesh from SubroomTemplate");
        @newRoom.Object = LoadRMesh("GFX\\map\\" + this.name);
        newRoom.Object.Scale(1 / 256.f, 1 / 256.f, 1 / 256.f, true);
        newRoom.Object.Position(x, y, z, true);
        newRoom.Object.Rotate(0, angle, 0, true);

        Console::CreateMessage("Returning RMesh from SubroomTemplate");
        return @newRoom;
    }
}

array<SubroomTemplate> subroomTemplates;

void RegisterSubroomTemplate(SubroomTemplate subroomTemplate) {
    subroomTemplates.InsertLast(subroomTemplate);
}

array<SubroomTemplate@> CollectSubroomTemplates(int width, int height, int zone) {
    array<SubroomTemplate@> collection;
    for (int i = 0; i < subroomTemplates.Length; i++) {
        if (subroomTemplates[i].width == width && subroomTemplates[i].height == height && subroomTemplates[i].zone == zone) {
            collection.InsertLast(@subroomTemplates[i]);
        }
    }
    return collection;
}

SubroomTemplate@ PickSubroomTemplate(array<SubroomTemplate@> subroomTemplatesToPick) {
    return @subroomTemplatesToPick[Rand(0, subroomTemplatesToPick.Length-1)];
}