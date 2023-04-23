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

- TODO: ch 2
- TODO: ch 3
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
1. use `@pytest.fixture`    
1. [`yield <some_optional_value>`](TODO) in fixture function to do 'before' & 'after' each test
1. [`return`](TODO) in the fixture function to do 'before' only 
the or return
1. Scopes: 
    - "function" (default):
    - "class":
    - "module":
    - "package":
    - "session":
1. [Pycharm support](https://www.jetbrains.com/help/pycharm/pytest.html#pytest-fixtures)


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
