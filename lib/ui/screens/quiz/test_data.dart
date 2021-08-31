import 'models.dart';

Quiz getTestQuiz() {
  return Quiz(title: 'Тестовый квиз',  questions: [
    Question(text: 'Здесь должно быть предложение, но программист не знает _______', options: [
      Option(text: 'Татарский', isCorrect: true),
      Option(text: 'Русский', isCorrect: false),
      Option(text: 'Ничего', isCorrect: false),
      Option(text: 'Что за программисты пошли?', isCorrect: false),
    ]),
    Question(text: 'Здесь могла быть ваша ________', options: [
      Option(text: 'Фраза', isCorrect: false),
      Option(text: 'Цитата', isCorrect: false),
      Option(text: 'Реклама', isCorrect: true),
      Option(text: 'Фотография', isCorrect: false),
    ]),
    Question(text: 'У ____ плохо с фантазией', options: [
      Option(text: 'Разработчика', isCorrect: true),
      Option(text: 'Татара', isCorrect: false),
      Option(text: 'Меня', isCorrect: false),
      Option(text: 'Тебя', isCorrect: false),
    ]),
    Question(text: 'Растет поколение, которое ____ мир', options: [
      Option(text: 'Любит этот', isCorrect: false),
      Option(text: 'Уничтожит', isCorrect: false),
      Option(text: 'Захватит', isCorrect: false),
      Option(text: 'Спасет', isCorrect: true),
    ]),
    Question(text: 'Последний _____', options: [
      Option(text: 'Вопрос', isCorrect: true),
      Option(text: 'Предложение', isCorrect: false),
      Option(text: 'Кофе', isCorrect: false),
      Option(text: 'Видео', isCorrect: false),
    ])
  ]);
}
