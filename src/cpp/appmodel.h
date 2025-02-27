#ifndef APPMODEL_H
#define APPMODEL_H

#include <QObject>
#include <QString>
#include <QVariantList>
#include <QDateTime>

class AppModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString dailyQuestion READ dailyQuestion NOTIFY dailyQuestionChanged)
    Q_PROPERTY(QVariantList quizQuestions READ quizQuestions NOTIFY quizQuestionsChanged)
    Q_PROPERTY(QVariantList conversationStarters READ conversationStarters NOTIFY conversationStartersChanged)
    Q_PROPERTY(QVariantList discoveryItems READ discoveryItems NOTIFY discoveryItemsChanged)

public:
    explicit AppModel(QObject *parent = nullptr);

    QString dailyQuestion() const;
    QVariantList quizQuestions() const;
    QVariantList conversationStarters() const;
    QVariantList discoveryItems() const;

signals:
    void dailyQuestionChanged();
    void quizQuestionsChanged();
    void conversationStartersChanged();
    void discoveryItemsChanged();

public slots:
    void generateNewDailyQuestion();
    void answerQuizQuestion(int index, const QString &answer);
    void getNewConversationStarter();

private:
    QString m_dailyQuestion;
    QVariantList m_quizQuestions;
    QVariantList m_conversationStarters;
    QVariantList m_discoveryItems;
    QDateTime m_lastQuestionDate;

    void loadQuestions();
    void loadConversationStarters();
    void loadDiscoveryItems();
    void checkDailyQuestion();
};

#endif // APPMODEL_H