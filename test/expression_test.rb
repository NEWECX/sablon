# -*- coding: utf-8 -*-
require "test_helper"

class ExpressionTest < Sablon::TestCase
end

class VariableExpressionTest < Sablon::TestCase
  def test_lookup_the_variable_in_the_context
    expr = Sablon::Expression.parse("first_name")
    assert_equal "Jane", expr.evaluate({"first_name" => "Jane", "last_name" => "Doe"})
  end

  def test_inspect
    expr = Sablon::Expression.parse("first_name")
    assert_equal "«first_name»", expr.inspect
  end
end

class LookupOrMethodCallTest < Sablon::TestCase
  def test_calls_method_on_object
    user = OpenStruct.new(first_name: "Jack")
    expr = Sablon::Expression.parse("user.first_name")
    assert_equal "Jack", expr.evaluate({"user" => user})
  end

  def test_calls_perform_lookup_on_hash_with_string_keys
    user = {"first_name" => "Jack"}
    expr = Sablon::Expression.parse("user.first_name")
    assert_equal "Jack", expr.evaluate({"user" => user})
  end

  def test_calls_perform_lookup_on_hash_with_symbol_keys
    skip
    user = {first_name: "Jack"}
    expr = Sablon::Expression.parse("user.first_name")
    assert_equal "Jack", expr.evaluate({"user" => user})
  end

  def test_inspect
    expr = Sablon::Expression.parse("user.first_name")
    assert_equal "«user.first_name»", expr.inspect
  end

  def test_compound_method_call
    user = {'first_name' => 'Jack', 'related_user' => {'first_name' => 'Jane'}}
    expr = Sablon::Expression.parse('user.related_user.first_name')
    assert_equal 'Jane', expr.evaluate({'user' => user})
  end
end
