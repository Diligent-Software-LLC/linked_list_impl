require_relative 'test_helper'

# LinkedListTest.
# @abstract
# Tests the LinkedList class.
class LinkedListTest < Minitest::Test

  # test_version_declared().
  # @abstract
  # The version was declared.
  def test_version_declared()
    refute_nil(::LinkedList::VERSION)
  end

  # test_conf_doc_f_ex().
  # @abstract
  # The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, and 
  # README.md files exist.
  def test_conf_doc_f_ex()
    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
  end

  # setup().
  # @abstract
  # Set fixtures.
  def setup()
  end

  # teardown().
  # @abstract
  # Cleanup.
  def teardown()
  end

end

