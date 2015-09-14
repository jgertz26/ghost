require "gosu"

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Ghost!"
    @new_game = true
    @font = Gosu::Font.new(20)
  end

  def update
  end

  def draw
    if @new_game
      @font.draw("Welcome to GHOST", 110, 100, 0, 2.5, 2.5, 0xff_ffff00)
      @font.draw("NEW GAME", 240, 230, 0, 1.5, 1.5, 0xff_ffff00)
      @font.draw("Press Enter", 256, 270, 0, 1.2, 1.2, 0xff_ffff00)
    else
      @font.draw("Human:", 10, 10, 0, 1.0, 1.0, 0xff_ffff00)
      @font.draw("Computer:", 540, 10, 0, 1.0, 1.0, 0xff_ffff00)
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbReturn
      @new_game = false
    end
  end
end

window = GameWindow.new
window.show
