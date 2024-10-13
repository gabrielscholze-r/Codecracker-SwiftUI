import SwiftUI
import CoreData
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Language.entity(),sortDescriptors: []) var language: FetchedResults<Language>
    @FetchRequest(entity: UserScores.entity(), sortDescriptors: []) var scores: FetchedResults<UserScores>
    
    
    var body: some View {
        TabView {
            HomePage(language: Array(language), scores: Array(scores))
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(1)
            
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(2)
            
        }
        .navigationTitle("CODECRACKER")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            //deleteAllData()
            if scores.isEmpty {
                addInitialScores()
                try? moc.save()
            }
            if language.isEmpty {
                addLanguagesAndQuestions()
                try? moc.save()
            }
        }
        
    }
    func addInitialScores() {
        if scores.isEmpty {
            let userScore = UserScores(context: moc)
            
            userScore.c = 1
            userScore.java = 1
            userScore.javascript = 1
            userScore.python = 1
            try? moc.save()
        }
    }
    
    
    func deleteAllData() {
        let entities = ["UserScores", "Language", "Question", "Option"]
        for entity in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try moc.execute(deleteRequest)
            } catch {
                print("Erro ao deletar dados da entidade \(entity): \(error)")
            }
        }
        try? moc.save()
    }
    
    
    func addLanguagesAndQuestions() {
        let languageC = Language(context: moc)
        languageC.id = Int32(1)
        languageC.name = "C"
        languageC.info = "Created in New Jersey (USA) in 1972, C is a low-level programming language that is highly efficient and powerful. It is often used in applications where control over hardware and performance are crucial, such as in the development of operating systems (Linux, for example), device drivers, and embedded software. C provides direct access to memory and system resources, making it the ideal choice for embedded systems and high-performance computing. Additionally, many modern languages, such as C++ and Java, have been heavily influenced by C, which remains a fundamental language in software engineering."
        languageC.latitude = 40.2206
        languageC.longitude = -74.7699
        
        let languageJava = Language(context: moc)
        languageJava.id = Int32(2)
        languageJava.name = "Java"
        languageJava.info="Created in California (USA) in 1995, Java is an object-oriented programming language known for its portability and reliability in large systems. Utilizing the JVM (Java Virtual Machine), it can be executed on any platform, making it a popular choice for large-scale enterprise applications. Java is widely used in the development of Android applications, as well as in building robust web servers using frameworks like Spring. It is also common in banking systems, telecommunications, and in the construction of distributed applications."
        languageJava.latitude = 36.7783
        languageJava.longitude = -119.4179

        
        let languageJavaScript = Language(context: moc)
        languageJavaScript.id = Int32(3)
        languageJavaScript.name = "JavaScript"
        languageJavaScript.info="Created in California (USA) in 1995, JavaScript is a programming language widely used in web development, both on the front-end and back-end. It allows for the addition of interactivity to web pages and is one of the main technologies, along with HTML and CSS, for creating dynamic interfaces. Furthermore, with the advent of Node.js, JavaScript is also used in the development of servers, APIs, and microservices. Other areas of application include mobile app development with frameworks like React Native and the creation of modern web applications using Angular, React, and Vue.js."
        languageJavaScript.latitude = 36.7783
        languageJavaScript.longitude = -119.4179

        
        let languagePython = Language(context: moc)
        languagePython.id = Int32(4)
        languagePython.name = "Python"
        languagePython.info = "Created in 1992 in Amsterdam (Netherlands), Python is a versatile programming language that is easy to learn and widely used in various fields. Its simple and clear syntax makes it ideal for beginners, while its power attracts experienced developers for advanced applications. It is the preferred language for data science, artificial intelligence, and machine learning, with libraries like Pandas, TensorFlow, and NumPy. Python is also widely used for task automation, scripting, web development with frameworks like Django and Flask, as well as data analysis and rapid prototyping."
        languagePython.latitude = 52.3676
        languagePython.longitude = 4.9041

        
        let cQuestions = [
            ("What is the correct syntax for a main function in C?", [
                ("int main() {}", true),
                ("void main {}", false),
                ("main() void", false),
                ("def main():", false)
            ]),
            ("Which of the following is used to declare a pointer in C?", [
                ("*", true),
                ("&", false),
                ("@", false),
                ("#", false)
            ]),
            ("Which of these is not a loop structure in C?", [
                ("for", false),
                ("do-while", false),
                ("repeat-until", true),
                ("while", false)
            ]),
            ("What is the size of an int on a 32-bit system?", [
                ("2 bytes", false),
                ("4 bytes", true),
                ("8 bytes", false),
                ("16 bytes", false)
            ]),
            ("Which operator is used to allocate memory in C?", [
                ("malloc()", true),
                ("calloc()", true),
                ("new", false),
                ("alloc()", false)
            ]),
            ("What is the output of printf('%d', 10 + 20);?", [
                ("30", true),
                ("1020", false),
                ("Error", false),
                ("10 + 20", false)
            ]),
            ("Which header file is required for using printf()?", [
                ("<stdio.h>", true),
                ("<stdlib.h>", false),
                ("<conio.h>", false),
                ("<string.h>", false)
            ]),
            ("How do you declare a constant in C?", [
                ("const int x = 10;", true),
                ("int const x = 10;", true),
                ("int x = const 10;", false),
                ("constant int x = 10;", false)
            ]),
            ("Which of these is a valid declaration of a function pointer?", [
                ("int (*ptr)();", true),
                ("int *ptr();", false),
                ("int ptr*();", false),
                ("void ptr();", false)
            ]),
            ("What is the output of this code: printf('%d', 1 + 2 * 3);?", [
                ("7", false),
                ("9", true),
                ("6", false),
                ("5", false)
            ]),
            ("What does 'sizeof' operator return?", [
                ("Size of variable in bytes", true),
                ("Size of variable in bits", false),
                ("Size of array", false),
                ("None of the above", false)
            ]),
            ("Which keyword is used to define a macro?", [
                ("#define", true),
                ("define", false),
                ("macro", false),
                ("#macro", false)
            ]),
            ("Which function is used to terminate a program?", [
                ("exit()", true),
                ("stop()", false),
                ("break()", false),
                ("return()", false)
            ]),
            ("What is the output of this code: printf('%c', 'A' + 1);?", [
                ("B", true),
                ("A", false),
                ("C", false),
                ("Error", false)
            ]),
            ("Which of the following is true about 'void'?", [
                ("It means no value", true),
                ("It means any value", false),
                ("It can be used to declare variables", false),
                ("None of the above", false)
            ])
        ]
        
        let javaQuestions = [
            ("Which keyword is used to define a class in Java?", [
                ("class", true),
                ("struct", false),
                ("define", false),
                ("type", false)
            ]),
            ("What is the size of an int in Java?", [
                ("4 bytes", true),
                ("2 bytes", false),
                ("8 bytes", false),
                ("Depends on the system", false)
            ]),
            ("Which method is used to start a thread in Java?", [
                ("start()", true),
                ("run()", false),
                ("init()", false),
                ("execute()", false)
            ]),
            ("What is the output of 'System.out.println(5 + 2 * 3);'?", [
                ("11", true),
                ("21", false),
                ("17", false),
                ("Error", false)
            ]),
            ("What is the default value of a boolean variable in Java?", [
                ("true", false),
                ("false", true),
                ("1", false),
                ("0", false)
            ]),
            ("Which of these is not a Java feature?", [
                ("Dynamic", false),
                ("Architecture-neutral", false),
                ("Use of pointers", true),
                ("Object-oriented", false)
            ]),
            ("Which of these is a valid declaration of a double variable?", [
                ("double d = 1.0;", true),
                ("double d = 1;", false),
                ("d double = 1.0;", false),
                ("double = 1.0 d;", false)
            ]),
            ("What is the output of 'System.out.println(10 + '5');'?", [
                ("15", false),
                ("105", true),
                ("Error", false),
                ("None of the above", false)
            ]),
            ("What is the main method in Java?", [
                ("public static void main(String[] args)", true),
                ("public void main(String args)", false),
                ("static void main(String args)", false),
                ("void main(String[] args)", false)
            ]),
            ("Which keyword is used to inherit a class in Java?", [
                ("extends", true),
                ("inherits", false),
                ("implements", false),
                ("uses", false)
            ]),
            ("Which of these is a wrapper class for int?", [
                ("Integer", true),
                ("Int", false),
                ("Number", false),
                ("Double", false)
            ]),
            ("What is the output of 'System.out.println(10 / 4);'?", [
                ("2", true),
                ("2.5", false),
                ("Error", false),
                ("None of the above", false)
            ]),
            ("Which method is used to read input from the console in Java?", [
                ("Scanner.next()", true),
                ("Console.read()", false),
                ("Input.read()", false),
                ("System.in()", false)
            ]),
            ("Which of these can be a constructor in Java?", [
                ("public ClassName()", true),
                ("ClassName public()", false),
                ("void ClassName()", false),
                ("static ClassName()", false)
            ]),
            ("What is the output of 'System.out.println(2 + 3 + \"Hello\");'?", [
                ("5Hello", true),
                ("Hello5", false),
                ("Hello2", false),
                ("Error", false)
            ]),
            ("Which of the following statements is used to create an object in Java?", [
                ("ClassName obj = new ClassName();", true),
                ("obj ClassName = new ClassName();", false),
                ("new ClassName obj();", false),
                ("ClassName obj();", false)
            ])
        ]
        
        let javascriptQuestions = [
            ("What is the correct syntax for referring to an external script called 'script.js'?", [
                ("<script src='script.js'>", true),
                ("<script href='script.js'>", false),
                ("<script ref='script.js'>", false),
                ("<script name='script.js'>", false)
            ]),
            ("Which symbol is used for comments in JavaScript?", [
                ("//", true),
                ("/* */", true),
                ("# ", false),
                ("<!-- -->", false)
            ]),
            ("What will the following code return: Boolean(1) + Boolean(0);?", [
                ("2", false),
                ("1", true),
                ("true", false),
                ("false", false)
            ]),
            ("Which of the following is not a JavaScript data type?", [
                ("undefined", false),
                ("boolean", false),
                ("integer", true),
                ("string", false)
            ]),
            ("How do you create a function in JavaScript?", [
                ("function myFunction()", true),
                ("create myFunction()", false),
                ("function:myFunction()", false),
                ("myFunction = function()", false)
            ]),
            ("What will the following code output: console.log(2 + '2');?", [
                ("22", true),
                ("4", false),
                ("Error", false),
                ("undefined", false)
            ]),
            ("Which of the following is used to add an event handler in JavaScript?", [
                ("addEventListener", true),
                ("onClick", false),
                ("addEvent", false),
                ("handleEvent", false)
            ]),
            ("What is the correct way to write a JavaScript array?", [
                ("var colors = ['red', 'green', 'blue']", true),
                ("var colors = (1: 'red', 2: 'green', 3: 'blue')", false),
                ("var colors = 'red', 'green', 'blue'", false),
                ("var colors = 'red' + 'green' + 'blue'", false)
            ]),
            ("How do you declare a variable in JavaScript?", [
                ("var myVar", true),
                ("variable myVar", false),
                ("declare myVar", false),
                ("myVar var", false)
            ]),
            ("Which method can be used to convert a JSON string into a JavaScript object?", [
                ("JSON.parse()", true),
                ("JSON.stringify()", false),
                ("JSON.convert()", false),
                ("JSON.object()", false)
            ]),
            ("What is the output of 'console.log(typeof NaN);'?", [
                ("number", true),
                ("undefined", false),
                ("NaN", false),
                ("error", false)
            ]),
            ("Which of the following is the correct way to create an object in JavaScript?", [
                ("var obj = {};", true),
                ("var obj = [];", false),
                ("var obj = () => {};", false),
                ("var obj = <{}>;", false)
            ]),
            ("Which operator is used to compare both value and type in JavaScript?", [
                ("===", true),
                ("==", false),
                ("!=", false),
                ("!==", false)
            ]),
            ("What will 'console.log(0.1 + 0.2 == 0.3);' output?", [
                ("true", false),
                ("false", true),
                ("undefined", false),
                ("Error", false)
            ]),
            ("How can you prevent the default behavior of an event in JavaScript?", [
                ("event.preventDefault()", true),
                ("event.stopPropagation()", false),
                ("event.defaultPrevent()", false),
                ("preventDefault(event)", false)
            ]),
            ("What does the 'this' keyword refer to in JavaScript?", [
                ("The current object", true),
                ("The global object", false),
                ("The previous object", false),
                ("None of the above", false)
            ])
        ]
        
        let pythonQuestions = [
            ("What is the correct syntax for defining a function in Python?", [
                ("def myFunction():", true),
                ("function myFunction():", false),
                ("def myFunction[]:", false),
                ("function:myFunction():", false)
            ]),
            ("Which of the following is a mutable data type in Python?", [
                ("List", true),
                ("Tuple", false),
                ("String", false),
                ("Integer", false)
            ]),
            ("What is the output of print(5 == 5)?", [
                ("True", true),
                ("False", false),
                ("Error", false),
                ("None", false)
            ]),
            ("Which symbol is used for comments in Python?", [
                ("#", true),
                ("//", false),
                ("/* */", false),
                ("<!-- -->", false)
            ]),
            ("How do you create a list in Python?", [
                ("myList = []", true),
                ("myList = {}", false),
                ("myList = ()", false),
                ("myList = < >", false)
            ]),
            ("What is the correct way to handle exceptions in Python?", [
                ("try...except", true),
                ("catch...try", false),
                ("except...try", false),
                ("try...catch", false)
            ]),
            ("What will be the output of 'print(2 ** 3)'?", [
                ("8", true),
                ("9", false),
                ("6", false),
                ("Error", false)
            ]),
            ("Which of the following is a valid dictionary in Python?", [
                ("myDict = {'key': 'value'}", true),
                ("myDict = ['key': 'value']", false),
                ("myDict = ('key', 'value')", false),
                ("myDict = 'key', 'value'", false)
            ]),
            ("How do you check the type of a variable in Python?", [
                ("type(var)", true),
                ("check(var)", false),
                ("var.type()", false),
                ("var.type", false)
            ]),
            ("What is the output of 'print([1, 2] + [3, 4])'?", [
                ("[1, 2, 3, 4]", true),
                ("[4, 3, 2, 1]", false),
                ("Error", false),
                ("None", false)
            ]),
            ("Which function is used to get user input in Python?", [
                ("input()", true),
                ("getInput()", false),
                ("read()", false),
                ("scanf()", false)
            ]),
            ("What does 'len()' function do in Python?", [
                ("Returns the length of an object", true),
                ("Returns the type of an object", false),
                ("Converts to string", false),
                ("Checks if an object is empty", false)
            ]),
            ("How can you create a tuple in Python?", [
                ("myTuple = (1, 2, 3)", true),
                ("myTuple = [1, 2, 3]", false),
                ("myTuple = {1, 2, 3}", false),
                ("myTuple = <1, 2, 3>", false)
            ]),
            ("What is the correct way to import a module in Python?", [
                ("import module", true),
                ("include module", false),
                ("using module", false),
                ("require module", false)
            ]),
            ("What is the output of 'print(bool(0))'?", [
                ("False", true),
                ("True", false),
                ("None", false),
                ("Error", false)
            ]),
            ("Which keyword is used to define a class in Python?", [
                ("class", true),
                ("struct", false),
                ("def", false),
                ("new", false)
            ])
        ]
        addQuestions(to: languagePython, questionsData: pythonQuestions)
        addQuestions(to: languageJavaScript, questionsData: javascriptQuestions)
        addQuestions(to: languageC, questionsData: cQuestions)
        addQuestions(to: languageJava, questionsData: javaQuestions)
    }
    
    func addQuestions(to language: Language, questionsData: [(String, [(String, Bool)])]) {
        for (questionText, optionsData) in questionsData {
            let question = Question(context: moc)
            question.id = Int32.random(in: 1...1000)
            question.question = questionText
            
            for (optionText, isCorrect) in optionsData {
                let option = Option(context: moc)
                option.answer = isCorrect
                option.option = optionText
                question.addToOptions(option)
            }
            
            language.addToQuestions(question)
        }
    }
}

#Preview {
    ContentView()
}
