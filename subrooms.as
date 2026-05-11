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
    return subroomTemplatesToPick[Rand(0, subroomTemplatesToPick.Length-1)];
}