def foo():
    try:
        print(111)
        return 333
    except Exception as e:
        raise e
    finally:
       print(222)

x = foo()
print(x)