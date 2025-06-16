extends Node

const 主题列表=["泥","草","雪","冰","雪","草"]

var 当前主题:int=0
var 主题贴图字典={
    "泥刺" : preload("res://图片/rock.png"),
    "泥刺下" : preload("res://图片/rockDown.png"),
    "草刺": preload("res://图片/rockGrass.png"),  
    "草刺下": preload("res://图片/rockGrassDown.png"),  
    "冰刺": preload("res://图片/rockIce.png"),  
    "冰刺下": preload("res://图片/rockIceDown.png"),  
    "雪刺": preload("res://图片/rockSnow.png"),  
    "雪刺下": preload("res://图片/rockSnowDown.png"),  
    "泥地": preload("res://图片/groundDirt.png"),  
    "冰地": preload("res://图片/groundIce.png"),  
    "草地": preload("res://图片/groundGrass.png"),  
    "石地": preload("res://图片/groundRock.png"),  
    "雪地": preload("res://图片/groundSnow.png"),
}

var 分数:int=0:
    set(值):
        分数=值
        分数变化.emit()

signal 分数变化()
signal 切换主题信号(主题:String)

func 切换主题():
    当前主题+=1
    if 当前主题==6:当前主题=0
    切换主题信号.emit(主题列表[当前主题])
