require_relative '../lib/secret_diary'

### WARNING ###
# For the purposes of this exercise, you are testing after
# the code has been written. This means your tests are prone
# to false positives!
#
# Make sure your tests work by deleting the bodies of the
# methods in `secret_diary.rb`, like this:
#
# ```ruby
# def write(new_message)
# end
# ```
#
# If they fail, then you know your tests are working
# as expected.
### WARNING ###

RSpec.describe SecretDiary do

    context "when locked" do

      it "refuses to be read" do
        diary = double :diary
        secret_diary = SecretDiary.new(diary)
        expect(secret_diary.read).to eq 'Go away!'
      end
      it "refuses to be written" do
        diary = double :diary
        secret_diary = SecretDiary.new(diary)
        expect(secret_diary.write("SomeText")).to eq 'Go away!'
      end
  end

  context "when unlocked" do

    it "gets read" do
      diary = double :diary
      allow(diary).to receive(:read).and_return("SomeText")
      secret_diary = SecretDiary.new(diary)
      secret_diary.unlock
      expect(secret_diary.read).to eq "SomeText"
    end

    it "gets written" do
      diary = double :diary
      expect(diary).to receive(:write).with ("SomeText")
      secret_diary = SecretDiary.new(diary)
      secret_diary.unlock
      secret_diary.write("SomeText")
    end
  end
end
