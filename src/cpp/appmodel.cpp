#include "appmodel.h"
#include <QDebug>
#include <QDate>
#include <QMap>

AppModel::AppModel(QObject *parent) : QObject(parent)
{
    loadQuestions();
    loadConversationStarters();
    loadDiscoveryItems();
    checkDailyQuestion();
}

QString AppModel::dailyQuestion() const
{
    return m_dailyQuestion;
}

QVariantList AppModel::quizQuestions() const
{
    return m_quizQuestions;
}

QVariantList AppModel::conversationStarters() const
{
    return m_conversationStarters;
}

QVariantList AppModel::discoveryItems() const
{
    return m_discoveryItems;
}

void AppModel::generateNewDailyQuestion()
{
    // In a real app, this would rotate through a list or fetch from a server
    QStringList questions = {
        "What was the happiest moment of your day today?",
        "What's something new you'd like us to try together?",
        "What's one thing you love about our relationship?",
        "What's your favorite memory of us together?",
        "What's something you'd like to accomplish together this year?"
    };
    
    int randomIndex = QDateTime::currentDateTime().toSecsSinceEpoch() % questions.size();
    m_dailyQuestion = questions.at(randomIndex);
    m_lastQuestionDate = QDateTime::currentDateTime();
    
    emit dailyQuestionChanged();
}

void AppModel::answerQuizQuestion(int index, const QString &answer)
{
    if (index >= 0 && index < m_quizQuestions.size()) {
        QVariantMap question = m_quizQuestions.at(index).toMap();
        question["userAnswer"] = answer;
        m_quizQuestions[index] = question;
        emit quizQuestionsChanged();
    }
}

void AppModel::getNewConversationStarter()
{
    // Rotate through conversation starters or get a random one
    QVariantMap starter = m_conversationStarters.first().toMap();
    m_conversationStarters.removeFirst();
    m_conversationStarters.append(starter);
    emit conversationStartersChanged();
}

void AppModel::loadQuestions()
{
    m_quizQuestions.clear();
    
    // Sample quiz questions
    QVariantMap q1;
    q1["question"] = "What's their favorite color?";
    q1["category"] = "Preferences";
    q1["userAnswer"] = "";
    m_quizQuestions.append(q1);
    
    QVariantMap q2;
    q2["question"] = "What's their dream vacation destination?";
    q2["category"] = "Dreams";
    q2["userAnswer"] = "";
    m_quizQuestions.append(q2);
    
    QVariantMap q3;
    q3["question"] = "What makes them feel most loved?";
    q3["category"] = "Affection";
    q3["userAnswer"] = "";
    m_quizQuestions.append(q3);
    
    QVariantMap q4;
    q4["question"] = "What's their favorite way to relax?";
    q4["category"] = "Lifestyle";
    q4["userAnswer"] = "";
    m_quizQuestions.append(q4);
    
    QVariantMap q5;
    q5["question"] = "What's their biggest goal for this year?";
    q5["category"] = "Ambitions";
    q5["userAnswer"] = "";
    m_quizQuestions.append(q5);
}

void AppModel::loadConversationStarters()
{
    m_conversationStarters.clear();
    
    QStringList starters = {
        "If you could change one thing about the world, what would it be?",
        "What's something you've always wanted to learn?",
        "If we could travel anywhere together right now, where would you want to go?",
        "What's the best advice anyone has ever given you?",
        "What are three things you're grateful for today?",
        "If you could have dinner with anyone, living or dead, who would it be?",
        "What's a small thing that makes you happy?",
        "What's something you're looking forward to in the next month?"
    };
    
    for (const QString &starter : starters) {
        QVariantMap item;
        item["text"] = starter;
        m_conversationStarters.append(item);
    }
}

void AppModel::loadDiscoveryItems()
{
    m_discoveryItems.clear();
    
    // Categories of discovery items
    QStringList categories = {"Favorites", "Childhood", "Dreams", "Habits", "Values", "Preferences"};
    
    QMap<QString, QStringList> discoveryPrompts;
    discoveryPrompts["Favorites"] = {
        "Favorite movie and why?", 
        "Favorite book of all time?", 
        "Favorite meal you've ever had?"
    };
    
    discoveryPrompts["Childhood"] = {
        "Favorite childhood memory?", 
        "What did you want to be when you grew up?", 
        "Favorite childhood toy?"
    };
    
    discoveryPrompts["Dreams"] = {
        "One place you've always wanted to visit?", 
        "Something you've always wanted to learn?", 
        "A dream you'd still like to accomplish?"
    };
    
    for (const QString &category : categories) {
        QVariantMap catItem;
        catItem["category"] = category;
        
        QVariantList prompts;
        if (discoveryPrompts.contains(category)) {
            for (const QString &prompt : discoveryPrompts[category]) {
                QVariantMap promptItem;
                promptItem["text"] = prompt;
                promptItem["completed"] = false;
                prompts.append(promptItem);
            }
        }
        
        catItem["prompts"] = prompts;
        m_discoveryItems.append(catItem);
    }
}

void AppModel::checkDailyQuestion()
{
    QDateTime currentDate = QDateTime::currentDateTime();
    
    // If we don't have a question yet or it's from a previous day, generate a new one
    if (m_dailyQuestion.isEmpty() || 
        m_lastQuestionDate.date() != currentDate.date()) {
        generateNewDailyQuestion();
    }
}