class Game < ActiveRecord::Base
	belongs_to :player1, :class_name => 'Leagueplayer'
	belongs_to :player2, :class_name => 'Leagueplayer'
	belongs_to :result
	belongs_to :league

  before_destroy :unlink_result

  private
    def unlink_result
      if self.result then
        # no longer claiming this result
        self.result.game_id = nil
        self.result.save
      end
    end
end
