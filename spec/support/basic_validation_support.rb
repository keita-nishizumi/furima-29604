module BasicValidationSupport
  # objはレコード、colはカラム名の文字列、nihongoはカラム名の日本語名
  def not_nil_validation(obj, col, nihongo)
    obj[col.to_sym] = nil
    obj.valid?
    expect(obj.errors.full_messages).to include("#{nihongo}を入力してください")
  end

  def not_zero_validation(obj, col, nihongo)
    obj[col.to_sym] = 0
    obj.valid?
    expect(obj.errors.full_messages).to include("#{nihongo}を選択してください")
  end

  def not_nil_validation_dynamic(obj, col, nihongo)
    obj.send("#{col}=", nil)
    obj.valid?
    expect(obj.errors.full_messages).to include("#{nihongo}を入力してください")
  end
end
