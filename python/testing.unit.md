# Overview
- Patterns for unit testing via [Pytest](https://docs.pytest.org)


# Setup
```bash
pyenv activate <my-virtual-env>

pip install pytest;

# -- verify
pytest --version;
```

## Pycharm setup 
- File | Settings | Tools | Python Integrated Tools
    - Set pytest as the default runner

- TODO: ch 4
- TODO: ch 5 - paramters
- TODO: ch 6 - markers
- TODO: ch 8 - config files
- TODO: ch 10 - mocks
- TODO: ch 11 - tox
- TODO: ch 12 - scripts
- TODO: ch 13 - debugging
- TODO: ch 14 - plugins
- TODO: improvements between v7.0 (when book written) and v7.3 (today) <-- first 8 pages of changelog


# Running tests
```
PROJECT_ROOT=/path/to/project/root;

# -- recurse from current dir into subdirs
pytest $PROJECT_ROOT;

pytest $PROJECT_ROOT/just_one_test.py;

# -- verbose output but no tracebacks
pytest ./ --tb=no --verbose;


# TODO: --no-header --no-summary -q
```

# [Fixtures](https://docs.pytest.org/en/6.2.x/reference.html#fixtures-api)
1. "Fixture" means a function which runs before or after a test
    1. Think beforeEach/afterEach in JUnit
1. Use [`@pytest.fixture`](https://docs.pytest.org/en/6.2.x/fixture.html) to define
1. [`yield <some_optional_value>`](https://docs.pytest.org/en/6.2.x/fixture.html#yield-fixtures-recommended) in fixture function to do 'before' & 'after' each test
the or return
1. [Scopes](https://docs.pytest.org/en/6.2.x/fixture.html#scope-sharing-fixtures-across-classes-modules-packages-or-session): lifetime/sharing of fixture
    - "function" (default): once per `test_` function
    - "class": once per test class (shared by all `test_` methods in class)
    - "module": TODO
    - "package": once per test directory
    - "session": once per test process
1. Pass fixture (function) name into the test function (as an argument)
1. [Pycharm support](https://www.jetbrains.com/help/pycharm/pytest.html#pytest-fixtures)
1. on cli, use [`--setup-show`](TODO) flag to debug fixture order
1. Define fixture in [`conftest.py`](https://docs.pytest.org/en/6.2.x/fixture.html#scope-sharing-fixtures-across-classes-modules-packages-or-session) to share/reuse
1. `autouse=True` fixtures might be useful for observability
    1. these can make code harder to reason about
1. Built-in fixtures
    1. TODO: temp dirs
    1. TODO: temp files


# parametrize
1. TODO: ...
1. [Pycharm support](https://www.jetbrains.com/help/pycharm/pytest.html#pytest-parametrize)


# Idioms
1. test **file** starts with `test_` or ends with `_test.py`
1. test function/method starts with `test_`
    ```python
    def test_foo():
        assert 1==1
    ```
1. use standard [`assert`](https://docs.python.org/3/reference/simple_stmts.html#the-assert-statement)
    1. [pytest rewrites asserts](https://docs.pytest.org/en/7.1.x/how-to/assert.html#assertion-introspection-details) to make messages clearer
1. works with [attr](https://www.attrs.org/en/stable/) and [dataclass](https://docs.python.org/3/library/dataclasses.html)
1. use [multiprocessing](https://docs.python.org/3/library/multiprocessing.html) to run tests in parallel
    1. See [Pycharm docs](https://www.jetbrains.com/help/pycharm/performing-tests.html#test-mutliprocessing)
1. fail using `pytest.fail("something bad happened")`

- TODO: hypothesis
- TODO: nose
- TODO: pytest rewrites asserts to be more useful


# Test functions that should fail
1. Example
    ```python
    def test_make_human_fly():
        with pytest.raises(GravityError, match=".* fell down"):
            person.try_to_fly()
    ```
1. See also [`ExceptionInfo`](https://docs.pytest.org/en/7.1.x/reference/reference.html#exceptioninfo)


# Assertion helper functions
1. Purpose: wrap complicated assertions in nice fn api
1. Example
    ```python
    def assert_friendly(person1: Person, person2: Person):
        __tracebackhide__ = True
        assert person1.fav_book == person2.fav_book
        if person1.likes_the_cold == person2.likes_the_cold:
            pytest.fail("they want different climates")
    ```

# Other Resources
1. https://www.jetbrains.com/help/pycharm/pytest.html
