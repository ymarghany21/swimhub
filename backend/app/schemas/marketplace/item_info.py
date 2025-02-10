from pydantic import Field
from typing import Optional
from enum import Enum

class ItemCategory(str, Enum):
    CLOTHING = "clothing"
    ACCESSORIES = "accessories"
    EQUIPMENT = "equipment"

class ItemSize(str, Enum):
    SMALL = "small"
    MEDIUM = "medium"
    LARGE = "large"
    XL = "xl"

class ItemAgeGroup(str, Enum):
    ADULT = "adult"
    JUNIOR = "junior"

class ItemCondition(str, Enum):
    USED = "used"
    NEW = "new"

class ItemSport(str, Enum):
    FITNESS = "fitness"
    SWIMMING = "swimming" 

class ItemGender(str , Enum):
    MEN = "men"
    WOMEN = "women"

class Itemcompitability(str, Enum):
    RACING = "racing"
    TRAINING = "training"

class ItemType(str, Enum):
    SWIM_WEAR = "swim_wear"
    GOOGLES = "goggles"
    BAGS = "bags"
    CAPS = "caps"
    EQUIPMENT = "equipment"
    
class Brand(str, Enum):
    ARENA = "arena"
    SPEEDO = "speedo"
    MADWAVE = "madwave"
    A3 = "a3"
    FUNKITA = "funkita"
    FUNKY_TRUNKS = "funky_trunks"
    ZOYA = "zoya"
    ONE_SWIM_POWER = "one_swim_power"
    FINIS = "finis"
    YINGFA = "yingfa"
    TEMPO = "tempo"
    MEGA_DOLPHIN = "mega_dolphin"
    TYR = "tyr"
    


class NumericSizes(str, Enum):
    SIZE_20 = "20"
    SIZE_21 = "21"
    SIZE_22 = "22"
    SIZE_23 = "23"
    SIZE_24 = "24"
    SIZE_25 = "25"
    SIZE_26 = "26"
    SIZE_27 = "27"
    SIZE_28 = "28"
    SIZE_29 = "29"
    SIZE_30 = "30"
    SIZE_31 = "31"
    SIZE_32 = "32"
    SIZE_33 = "33"
    SIZE_34 = "34"
    SIZE_35 = "35"
    SIZE_36 = "36"
    SIZE_37 = "37"
    SIZE_38 = "38"
    SIZE_39 = "39"
    SIZE_40 = "40"

    
