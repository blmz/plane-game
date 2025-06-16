extends CanvasLayer
@onready var 结算界面: TextureRect = $结算界面
@onready var 游戏内界面: Control = $游戏内界面
@onready var 动画节点: AnimationPlayer = $动画节点
@onready var 游戏结束UI: TextureRect = $游戏结束
@onready var 分数: Label = $结算界面/分数
@onready var 计分板: Label = $游戏内界面/计分板

signal 重开信号()

func _ready() -> void:
    全局脚本.分数变化.connect(分数更新)

func _process(delta: float) -> void:
    pass

func 分数更新():
    计分板.text=str(全局脚本.分数)

func 重开游戏():
    游戏内界面.visible=true
    结算界面.visible=false
    游戏结束UI.visible=false
    全局脚本.切换主题()
    重开信号.emit()

func 游戏结束():
    游戏内界面.visible=false
    结算界面.visible=true
    分数.text=str(全局脚本.分数)
    动画节点.play("显示")

func 退出游戏():
    get_tree().quit()
