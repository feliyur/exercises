//
// Created by Yuri on 15/07/2018.
// Contact yurif@cs.technion.ac.il
//------------------------------------------------------------------------
//
// Implements a simple parser tool.
// CommandParser associates command name (first word) with a CommandHandler.
// Input text stream is parsed line-by-line, where the corresponding
// CommandHandler gets the rest of each line (except for the first word).
// By default, blank lines are ignored (can be overridden by adding handler
// for empty command ""), lines starting with '#' followed by blank chars
// are considered comments, and echoed (can be overridden by adding handler
// for "#").
//
// User should inherit CommandHandler for each command and register
// handlers using CommandParser::add. After all handlers are registered,
// CommandParser::parse_single can be used to parse a single line of inputs,
// while CommandParser::parse_all can be used to parse all lines until
// end of stream reached.
//
// Interface:
//
// class CommandParser
//
//  add(std::string const& handler_id, std::unique_ptr<CommandHandler> ch)
//      adds <ch> as handler for command <handler_id>.
//
//  std::istream& parse_single(std::istream& ist)
//      parses single line from ist
//
//  std::istream& parse_single(std::istream& ist)
//      parses all lines until end of ist
//
//------------------------------------------------------------------------

#ifndef EX5_COMMANDPARSER_H
#define EX5_COMMANDPARSER_H

#include <iostream>
#include <string>
#include <memory>
#include <map>
#include <sstream>


namespace mtm {

    class CommandHandler {
    public:
        virtual std::istream& operator ()(std::istream&)=0; // default: no-op
        virtual ~CommandHandler() {}
    };

    class CommandParser
    {
        class CommentHandler : public CommandHandler
        {
        public:
            virtual std::istream& operator ()(std::istream& ist) override
            {
                std::string comment;
                std::getline(ist, comment);
                std::cout << "# " << comment << std::endl;
                return ist;
            } // default: echo comment

        };  // no-op (default)

        class BlankLineHandler : public CommandHandler
        {
        public:
            virtual std::istream& operator ()(std::istream& ist) override
            {
//                std::cout << std::endl;
                return ist;
            } // default: no-op

        };  // no-op (default)

    public:
        typedef std::map<std::string, std::unique_ptr<CommandHandler>> HandlersContainer;

        class NoHandler : public std::exception
        {
        public:
            std::string m_HandlerID;
            NoHandler(std::string const& msg) : m_HandlerID(msg) {}
        };

        // Default: echo blank and comment lines
        CommandParser()
        {
            m_Handlers["#"] = std::move(std::unique_ptr<CommandHandler>(new CommentHandler));
            m_Handlers[""] = std::move(std::unique_ptr<CommandHandler>(new BlankLineHandler));
        }

        CommandParser(HandlersContainer&& handlers) : m_Handlers(std::move(handlers))  {}

        void add(std::string const& handler_id, std::unique_ptr<CommandHandler> ch)
        {
            m_Handlers[handler_id] = std::move(ch);
        }


        std::istream& parse_single(std::istream& ist)
        {
            std::string command;
            ist >> command;
            auto it = m_Handlers.find(command);
            if (m_Handlers.end() == it)
                throw NoHandler(command);

            auto& handler = *(it->second);
            return handler(ist);
        }

        std::istream& parse_all(std::istream& ist)
        {
            std::string buf;
            while (std::getline(ist, buf))
            {
                std::istringstream sstr(buf);
                parse_single(sstr);
            }
            return ist;
        }

    private:
        HandlersContainer m_Handlers;
    };

} // namespace mtm

#endif //EX5_COMMANDPARSER_H
