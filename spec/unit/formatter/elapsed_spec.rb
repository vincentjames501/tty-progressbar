# coding: utf-8

require 'spec_helper'

RSpec.describe TTY::ProgressBar, 'elapsed' do
  let(:output) { StringIO.new('', 'w+') }

  before { Timecop.safe_mode = false }

  it "displays elapsed time" do
    time_now = Time.local(2014, 10, 5, 12, 0, 0)
    Timecop.freeze(time_now)
    progress = TTY::ProgressBar.new(":elapsed", output: output, total: 10)

    5.times do |sec|
      time_now = Time.local(2014, 10, 5, 12, 0, sec)
      Timecop.freeze(time_now)
      progress.advance
    end

    output.rewind
    expect(output.read).to eq([
      "\e[1G 0s",
      "\e[1G 1s",
      "\e[1G 2s",
      "\e[1G 3s",
      "\e[1G 4s"
    ].join)
    Timecop.return
  end
end
