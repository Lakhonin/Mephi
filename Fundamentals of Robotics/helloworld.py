def your_function(greeting):
  result = (greeting + ' ' + "World!")
  return result

for greeting in ["Hello", "Hi", "Привет"]:
  print("Greeting: ", greeting)
  result = your_function(greeting)
  print("Result: ", result)
