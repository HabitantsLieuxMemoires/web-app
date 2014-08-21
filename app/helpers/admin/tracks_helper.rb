module Admin::TracksHelper

  def track_change_as_diff(from, to)
    Diffy::Diff.new(from, to, :context => 1).to_s(:html)
  end

end
