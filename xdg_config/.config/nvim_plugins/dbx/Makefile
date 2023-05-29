NEOTEST_DIR = misc/neotest
PLENARY_DIR = misc/plenary
TREESITTER_DIR = misc/treesitter
LUASOCKET_DIR = misc/luasocket
TEST_DIR = tests

test: $(NEOTEST_DIR) $(PLENARY_DIR) $(TREESITTER_DIR) $(LUASOCKET_DIR)
	nvim --headless --clean \
	-u $(TEST_DIR)/test_init.lua \
	-c "PlenaryBustedDirectory $(TEST_DIR) { minimal_init = 'test_init.lua' }"

$(NEOTEST_DIR):
	git clone --depth=1 --no-single-branch https://github.com/nvim-neotest/neotest $(NEOTEST_DIR)
	@rm -rf $(NEOTEST_DIR)/.git

$(PLENARY_DIR):
	git clone --depth=1 --no-single-branch https://github.com/nvim-lua/plenary.nvim $(PLENARY_DIR)
	@rm -rf $(PLENARY_DIR)/.git

$(TREESITTER_DIR):
	git clone --depth=1 --no-single-branch https://github.com/nvim-treesitter/nvim-treesitter $(TREESITTER_DIR)
	@rm -rf $(TREESITTER_DIR)/.git

$(LUASOCKET_DIR):
	git clone --depth=1 --no-single-branch https://github.com/lunarmodules/luasocket $(LUASOCKET_DIR)
	@rm -rf $(LUASOCKET_DIR)/.git
