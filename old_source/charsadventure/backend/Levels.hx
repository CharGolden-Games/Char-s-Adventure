package charsadventure.backend;


//todo make an actual map system, that's actually good.
class Levels {
    final charHouse:Array<Array<String>> = [
        ['Char_s_House']
    ];

    final charIsleMap:Array<Array<String>> = [
        ['Char_Isle'],
    ];

    final triditeCityMap:Array<Array<String>> = [
        ['Tridite_City'],
    ];

    final michealForestMap:Array<Array<String>> = [
        ['Micheals_Forest'],
    ];

    final michealHutMap:Array<Array<String>> = [
        ['Micheal_s_hut'],
    ];

    final miltonCreaksSaloonMap:Array<Array<String>> = [
        ['Milton_s_Creaks_Saloon'],
    ];

    final miltonsCreaksMap:Array<Array<String>> = [
        ['Milton_s_Creaks'],
    ];

    final miltonsCreaksJailMap:Array<Array<String>> = [
        ['Milton_s_Creaks_Jail'],
    ];

    final miltonsCreaksInnMap:Array<Array<String>> = [
        ['Milton_s_Creaks_Inn'],
    ];

    final hopesBluffMap:Array<Array<String>> = [
        ['Hope_s_Bluff'],
    ];

    final hopesBluffBarMap:Array<Array<String>> = [
        ['Hope_s_Bluff_Bar'],
    ];

    final hopesBluffInnMap:Array<Array<String>> = [
        ['Hope_s_Bluff_Bar'],
    ];

    final hopesBluffBankMap:Array<Array<String>> = [
        ['Hope_s_Bluff_Bank'],
    ];

    final hopesBluffGeneralShopMap:Array<Array<String>> = [
        ['Hope_s_Bluff_General_Shop'],
    ];

    final hopesBluffArmory:Array<Array<String>> = [
        ['Hope_s_Bluff_Armory'],
    ];

    public function loadMap(level:Int):Array<Array<String>>
    {
        switch (level) {
            case 0:
                return charHouse;
            case 1:
                return charIsleMap;
            case 2:
                return triditeCityMap;
            case 3:
                return michealForestMap;
            case 4:
                return michealHutMap;
            case 5:
                return miltonCreaksSaloonMap;
            case 6:
                return miltonsCreaksMap;
            case 7:
                return miltonsCreaksJailMap;
            case 8:
                return miltonsCreaksInnMap;
            case 9:
                return hopesBluffMap;
            case 10:
                return hopesBluffBarMap;
            case 11:
                return hopesBluffBankMap;
            case 12:
                return hopesBluffGeneralShopMap;
            case 13:
                return hopesBluffInnMap;
            case 14:
                return hopesBluffArmory;
        }
        
        trace('[WARN]: Int out of bounds!');
        return charHouse;
    }
}
