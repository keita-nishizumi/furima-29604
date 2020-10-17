module ItemSupport
  # itemはitemレコード、colはカラム名の文字列、nihongoはカラム名の日本語名
  def item_nil_validation(item, col, nihongo)
    item[col.to_sym] = nil
    item.valid?
    expect(@item.errors.full_messages).to include("#{nihongo}を入力してください")
  end

  def not_zero_validation(item, col, nihongo)
    item[col.to_sym] = 0
    item.valid?
    expect(@item.errors.full_messages).to include("#{nihongo}を選択してください")
  end
end
