# ========================================
# 変数代入
# ========================================
# make get_info url=https:www.yahoo.co.jp で上書きできる
url     = https://issus.me
options = -i -v

# 変数の利用 $(variable)
get_info:
	curl $(options) $(url)

get_info_no_stdout:
	# @を先頭につけるとこのタスク名が最初に流れない
	@curl $(options) $(url)

# 「:=」: 即時評価
# 「=」 : 遅延評価
lscmd_lazy = ls $(ls_option)
lscmd     := ls $(ls_option)
ls_option = -la

# option反映される
lscmd_lazy:
	$(lscmd_lazy)

# option反映されない. 定義時にls_optionがまだ未定義だったのでブランクが展開されているため
lscmd:
	$(lscmd)



# ========================================
# 依存関係の定義 
# ========================================
# cmd: 依存物 で定義する

# 依存物がないとき => error
# make: *** No rule to make target `no_such_file_exists', needed by `depend'.  Stop.
depend: no_such_file_exists
	echo 10000

# 依存する「ファイル」があれば実行できる
has_depend_file: depended.txt
	cat depended.txt

# 依存先は「makeコマンド」でもOK
depend_cmd: depended_cmd
	echo 'i depends on depended_cmd'

depended_cmd:
	echo 'i am depended depend_cmd'


# ========================================
# 複数のコマンドを実行 
# ========================================
# 1行ごとに実行
multiple:
	echo 1 + 1
	echo 2 + 2

# まとめて1コマンドを開業したい場合はバックスラッシュ
for:
	@for i in {1..10}; do \
		echo $$i; \
	done

# ========================================
# 制御構文 
# ========================================
ifeq ($(url), https://issus.me)
	sitename = issus
else ifeq($(url), https://paymo.life)
	sitename = paymo
else
	sitename = example.com
endif

sitename:
	echo $(sitename)
# ========================================
# その他 
# ========================================
# https://www.youtube.com/watch?v=furP-TvOu8c ここが詳しそう
# べらぼうにあるので一旦きになるものだけかく
# - makefile内で使える関数: sbust, strip, filter, sort, dir, words, ....
# - override
# - include
# - 一般的な約束事
